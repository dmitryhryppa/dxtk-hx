package app;
import dxtk.MouseState;
import dxtk.Gamepad;
import dxtk.SpriteBatch;
import dxtk.CommonStates;

@:buildXml('
<set name="dir" value="${haxelib:dxtk-hx}/dxtk11" />
<set name="dir_imgui" value="${haxelib:dxtk-hx}/imgui" />
<files id="haxe">
    <compilerflag value="-I${dir}/Inc/"/>
    <compilerflag value="-I${dir_imgui}/include/"/>
</files>

<files id="__main__">
    <compilerflag value="-I${dir}/Inc/"/>
    <compilerflag value="-I${dir_imgui}/include/"/>

    <file name="${dir_imgui}/imgui.cpp" />
    <file name="${dir_imgui}/imgui_demo.cpp" />
    <file name="${dir_imgui}/imgui_draw.cpp" />
    <file name="${dir_imgui}/imgui_impl_win32.cpp" />
    <file name="${dir_imgui}/imgui_impl_dx11.cpp" />
    <file name="${dir_imgui}/imgui_widgets.cpp" />
</files>

<target id="haxe" tool="linker" toolid="exe">
    <lib name="d3d11.lib" />
    <lib name="d3dcompiler.lib" />
    <lib name="dxgi.lib" />
    <lib name="RuntimeObject.lib" />

    <lib name="${dir}/Bin/Desktop_2017/Win32/Release/DirectXTK.lib" /> 
</target>
')

@:headerCode('
    #include <Windows.h>
    #include <memory>
    #include <d3d11.h>
    #include <Mouse.h>

    #include <imgui.h>
    #include <imgui_impl_win32.h>
    #include <imgui_impl_dx11.h>
')

@:headerClassCode('
    HWND m_handle;
    MSG msg;
        
    int vsync = 1;

    std::unique_ptr<DirectX::Mouse> mouse;

    //D3D11 stuff
    IDXGISwapChain *m_swapChain = nullptr;
    ID3D11Device *m_device = nullptr;
    ID3D11DeviceContext *m_deviceContext = nullptr;

    ID3D11RenderTargetView* m_renderTargetView = nullptr;
    D3D11_TEXTURE2D_DESC m_backBufferDesc;
')

@:cppFileCode('
    extern LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);

    LRESULT CALLBACK winProc (HWND handle, UINT msg, WPARAM wparam, LPARAM lparam) {
        if (msg == WM_DESTROY || msg == WM_CLOSE) {
            PostQuitMessage(0);
            return 0;
        }

        if (ImGui_ImplWin32_WndProcHandler(handle, msg, wparam, lparam)) return true;
        
        switch (msg) {
            case WM_KEYDOWN:
                if (wparam == VK_ESCAPE) {
                    if (MessageBox(nullptr, "Are you sure you want to exit?", "Really?", MB_YESNO | MB_ICONQUESTION) == IDYES) {
                        //Release the windows allocated memory  
                        DestroyWindow(handle);
                    }
                }
                return 0;

            case WM_DESTROY:	//if x button in top right was pressed
                PostQuitMessage(0);
                return 0;

            case WM_SYSKEYDOWN:
            case WM_KEYUP:
            case WM_SYSKEYUP:
                //DirectX::Keyboard::ProcessMessage(msg, wparam, lparam);
                break;
            case WM_ACTIVATEAPP:
                //DirectX::Keyboard::ProcessMessage(msg, wparam, lparam);
                DirectX::Mouse::ProcessMessage(msg, wparam, lparam);
                break;
            case WM_INPUT:
            case WM_MOUSEMOVE:
            case WM_LBUTTONDOWN:
            case WM_LBUTTONUP:
            case WM_RBUTTONDOWN:
            case WM_RBUTTONUP:
            case WM_MBUTTONDOWN:
            case WM_MBUTTONUP:
            case WM_MOUSEWHEEL:
            case WM_XBUTTONDOWN:
            case WM_XBUTTONUP:
            case WM_MOUSEHOVER:
                DirectX::Mouse::ProcessMessage(msg, wparam, lparam);
                break;
        }

        return DefWindowProc(handle, msg, wparam, lparam);
    }
')
class Dxtk {
    public var isRunning(default, null):Bool = false;
    public var vsyncEnabled:Bool = true;
    
    private var gamepad:Gamepad;
    private var spriteBatch:SpriteBatch;
    private var commonStates:CommonStates;
    private var content:Content;
    
    public function new () {

    }

    public function init (title:String, width:Int, height:Int, isFullscreen:Bool):Bool {
        untyped __cpp__('
            std::memset(&msg, 0, sizeof(msg));

            WNDCLASS wc;
            std::memset(&wc, 0, sizeof(wc));
            wc.style = CS_OWNDC;
            wc.lpfnWndProc = winProc;
            wc.hCursor = LoadCursor(nullptr, IDC_ARROW);
            wc.lpszClassName = "DirectXTK";
            RegisterClass(&wc);

            auto screenWidth = GetSystemMetrics(SM_CXSCREEN);
            auto screenHeight = GetSystemMetrics(SM_CYSCREEN);

            m_handle = CreateWindow("DirectXTK", {0}.c_str(), WS_POPUP | WS_CAPTION | WS_SYSMENU | WS_VISIBLE, (screenWidth - {1}) / 2, (screenHeight - {2}) / 2, {1}, {2}, nullptr, nullptr, nullptr, nullptr);

            DXGI_SWAP_CHAIN_DESC swapChainDesc;
            std::memset(&swapChainDesc, 0, sizeof(swapChainDesc));
            
            swapChainDesc.BufferCount = 1;
            swapChainDesc.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
            swapChainDesc.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
            swapChainDesc.OutputWindow = m_handle;
            swapChainDesc.SampleDesc.Count = 1;
            swapChainDesc.SampleDesc.Quality = 0;
            swapChainDesc.Windowed = !{3};
        
            auto result = D3D11CreateDeviceAndSwapChain(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, D3D11_CREATE_DEVICE_DEBUG, nullptr, 0, D3D11_SDK_VERSION, &swapChainDesc, &m_swapChain, &m_device, nullptr, &m_deviceContext);
            if (result != S_OK) {
                return false;
            }
        
            //Create backbuffer
            ID3D11Texture2D* backbuffer;
            m_swapChain->GetBuffer(0, __uuidof(ID3D11Texture2D), reinterpret_cast<void**>(&backbuffer));
            result = m_device->CreateRenderTargetView(backbuffer, nullptr, &m_renderTargetView);

            if (result != S_OK) {
                return false;
            }
        
            backbuffer->GetDesc(&m_backBufferDesc);
            backbuffer->Release();


            // Setup Dear ImGui binding
            IMGUI_CHECKVERSION();
            ImGui::CreateContext();
            ImGuiIO& io = ImGui::GetIO(); (void)io;
            //io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;  // Enable Keyboard Controls

            ImGui_ImplWin32_Init(m_handle);
            ImGui_ImplDX11_Init(m_device, m_deviceContext);

            // Setup style
            //ImGui::StyleColorsClassic();
            ImGui::StyleColorsDark()
        ', title, width, height, isFullscreen);

        untyped __cpp__('mouse = std::make_unique<DirectX::Mouse>()');
        this.commonStates = untyped __cpp__('new DirectX::CommonStates(m_device)');
        this.spriteBatch = untyped __cpp__('new DirectX::SpriteBatch(m_deviceContext)');
        this.gamepad = untyped __cpp__('new DirectX::GamePad()');
        this.content = Content.create(untyped __cpp__('m_device'));
        return true;
    }

    public function run (game:IGame):Void {
        if (!isRunning) {
            game.loadContent(this.content);
            while(true) {
                untyped __cpp__('
                    if (PeekMessage(&msg, nullptr, 0, 0, PM_REMOVE)) {
                        if (msg.message == WM_QUIT) {
                            break;
                        }
                        TranslateMessage(&msg);
                        DispatchMessage(&msg);
                    }

                    // Start the Dear ImGui frame
                    ImGui_ImplDX11_NewFrame();
                    ImGui_ImplWin32_NewFrame();
                    ImGui::NewFrame()
                ');
                game.onDebugGUI();
                untyped __cpp__('
                    ImGui::Render();

                    m_deviceContext->OMSetRenderTargets(1, &m_renderTargetView, nullptr);
            
                    auto viewport = CD3D11_VIEWPORT(0.0f, 0.0f, static_cast<float>(m_backBufferDesc.Width), static_cast<float>(m_backBufferDesc.Height));
                    m_deviceContext->RSSetViewports(1, &viewport);
            
                    float clearColor[] = { 0.45f, 0.55f, 1.0f, 1.0f };
                    m_deviceContext->ClearRenderTargetView(m_renderTargetView, clearColor)
                ');
                
                game.onGamepadInput(gamepad);
                game.onMouseState(untyped __cpp__('mouse->GetState()'));
                game.onUpdate(0.16);
                game.onDraw(spriteBatch, commonStates);
                untyped __cpp__('ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData())');
                
                untyped __cpp__('m_swapChain->Present({0}, 0); //1 for v-sync', vsyncEnabled ? 1 : 0);
            }
            exit();
        }
        isRunning = true;
    }

    public function exit ():Void {
        untyped __cpp__ ('
            m_swapChain->Release();
            m_device->Release();
            m_deviceContext->Release();
            m_renderTargetView->Release()
        ');
        
        untyped __cpp__('{0}->destroy()', spriteBatch);
        untyped __cpp__('{0}->destroy()', commonStates);
    }
}
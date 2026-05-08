Set WshShell = CreateObject("WScript.Shell")
WshShell.CurrentDirectory = "C:\Users\LIMAMORIM\Downloads\Projetos\04\open-design"
WshShell.Run "cmd /k npx pnpm tools-dev run web --daemon-port 17456 --web-port 17573", 7, False

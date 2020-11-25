import Terminal
import strutils
import rdstdin

const mantle_ip: string = "51.161.35.208"
var hosts_file: string
const optifine_domain = "s.optifine.net"

system.addQuitProc(resetAttributes)
setForegroundColor(fgWhite)
echo("""
                    _   _            _       _     
  /\/\   __ _ _ __ | |_| | ___   ___| |_   _| |__  
 /    \ / _` | '_ \| __| |/ _ \ / __| | | | | '_ \ 
/ /\/\ \ (_| | | | | |_| |  __/| (__| | |_| | |_) |
\/    \/\__,_|_| |_|\__|_|\___(_)___|_|\__,_|_.__/ 
""")

proc exit(error: string, color: ForegroundColor, exitCode: int) =
    setForegroundColor(color)
    echo(error)
    resetAttributes()
    echo("")
    discard readLineFromStdin("Press Enter to exit...")
    quit(exitCode)

case hostOS:
    of "windows":
        hosts_file = "C:\\Windows\\System32\\Drivers\\etc\\hosts"
    of "linux":
        hosts_file = "/etc/hosts"
    of "macosx":
        hosts_file = "/private/etc/hosts"
    else:
        exit("ERROR! Your operating system is unsupported.", fgRed, 1)

# Check if Mantle is already installed, and if so remove it.
try:
    if optifine_domain in read_file(hosts_file):
        var final_hosts: string
        for line in lines(hosts_file):
            if optifine_domain notin line:
                final_hosts.add(line & "\n")
        try:
            writeFile(hosts_file, final_hosts)
            exit("Success! Existing cape loader has been uninstalled.", fgGreen, 0)
        except IOError:
            exit("ERROR! Cannot write to hosts file. Run the installer again with administrator privileges.", fgRed, 1)
    else:
        var final_hosts = readFile(hosts_file)
        final_hosts = final_hosts & "\n" & mantle_ip & " " & optifine_domain

        try:
            writeFile(hosts_file, final_hosts)
            exit("Success! Mantle has been installed.", fgGreen, 0)
        except IOError:
            exit("ERROR! Cannot write to hosts file. Run the installer again with administrator privileges.", fgRed, 1)
except IOError:
    exit("ERROR! Um... Do you even *have* a hosts file? I can't find it.", fgRed, 1)
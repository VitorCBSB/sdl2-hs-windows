# Based on the script given here
# https://www.reddit.com/r/haskellgamedev/comments/49nbhj/windows_sdl_install_script/
# but the user for that post has been deleted, so I can't credit them by name.

# Initialization
$tar = ".tar"
$tar_gz = $tar + ".gz"
$zip = ".zip"

$install_dir = "C:\sdl"
$target_dir = ""
$pkg_config_subdir = "\lib\pkgconfig"

$sdl2_dir       = $install_dir + "\SDL2-2.0.4"
$sdl2_image_dir = $install_dir + "\SDL2_image-2.0.1"
$sdl2_mixer_dir = $install_dir + "\SDL2_mixer-2.0.1"
$sdl2_ttf_dir   = $install_dir + "\SDL2_ttf-2.0.14"

$sdl2_binding_dir       = $install_dir + "\sdl2-2.1.1"
$sdl2_image_binding_dir = $install_dir + "\sdl2-image-windows"
$sdl2_mixer_binding_dir = $install_dir + "\sdl2-mixer-windows"
$sdl2_ttf_binding_dir   = $install_dir + "\sdl2-ttf-windows"

$gettext_dir    = $install_dir + "\gettext"
$glib_dir       = $install_dir + "\glib"
$pkg_config_dir = $install_dir + "\pkg_config"

$sdl_header_url = "https://hg.libsdl.org/SDL/raw-file/e217ed463f25/include/SDL_platform.h"

$sdl2_url       = "https://www.libsdl.org/release/SDL2-devel-2.0.4-mingw.tar.gz"
$sdl2_image_url = "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.1-mingw.tar.gz"
$sdl2_mixer_url = "https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.1-mingw.tar.gz"
$sdl2_ttf_url   = "https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-devel-2.0.14-mingw.tar.gz"

$sdl2_binding_url       = "https://github.com/haskell-game/sdl2/archive/v2.1.1.zip"
$sdl2_image_binding_url = "https://github.com/nxths/sdl2-image/archive/windows.zip"
$sdl2_mixer_binding_url = "https://github.com/nxths/sdl2-mixer/archive/windows.zip"
$sdl2_ttf_binding_url   = "https://github.com/nxths/sdl2-ttf/archive/windows.zip"

$gettext_url    = "http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/gettext-runtime_0.18.1.1-2_win32.zip"
$glib_url       = "http://ftp.gnome.org/pub/gnome/binaries/win32/glib/2.28/glib_2.28.8-1_win32.zip"
$pkg_config_url = "http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config_0.26-1_win32.zip"

New-Item $install_dir -type directory -force

$env:PKG_CONFIG_PATH = $sdl2_dir       + $target_dir + $pkg_config_subdir + ";" + 
                       $sdl2_image_dir + $target_dir + $pkg_config_subdir + ";" + 
                       $sdl2_mixer_dir + $target_dir + $pkg_config_subdir + ";" + 
                       $sdl2_ttf_dir   + $target_dir + $pkg_config_subdir

$env:PATH = $env:PATH + ";" + $sdl2_dir       + $target_dir + "\bin;" +
                              $sdl2_image_dir + $target_dir + "\bin;" +
                              $sdl2_mixer_dir + $target_dir + "\bin;" +
                              $sdl2_ttf_dir   + $target_dir + "\bin;" +
                              $pkg_config_dir + "\bin"

$client = New-Object System.Net.WebClient

# Body
$client.DownloadFile($sdl2_url,       $sdl2_dir       + $tar_gz)
$client.DownloadFile($sdl2_image_url, $sdl2_image_dir + $tar_gz)
$client.DownloadFile($sdl2_mixer_url, $sdl2_mixer_dir + $tar_gz)
$client.DownloadFile($sdl2_ttf_url,   $sdl2_ttf_dir   + $tar_gz)

$client.DownloadFile($sdl2_binding_url,       $sdl2_binding_dir       + $zip)
$client.DownloadFile($sdl2_image_binding_url, $sdl2_image_binding_dir + $zip)
$client.DownloadFile($sdl2_mixer_binding_url, $sdl2_mixer_binding_dir + $zip)
$client.DownloadFile($sdl2_ttf_binding_url,   $sdl2_ttf_binding_dir   + $zip)

$client.DownloadFile($gettext_url,    $gettext_dir    + $zip)
$client.DownloadFile($glib_url,       $glib_dir       + $zip)
$client.DownloadFile($pkg_config_url, $pkg_config_dir + $zip)

.\7za e ($sdl2_dir       + $tar_gz) ("-o" + $install_dir)
.\7za e ($sdl2_image_dir + $tar_gz) ("-o" + $install_dir)
.\7za e ($sdl2_mixer_dir + $tar_gz) ("-o" + $install_dir)
.\7za e ($sdl2_ttf_dir   + $tar_gz) ("-o" + $install_dir)

.\7za x ($sdl2_dir       + $tar) ("-o" + $install_dir)
.\7za x ($sdl2_image_dir + $tar) ("-o" + $install_dir)
.\7za x ($sdl2_mixer_dir + $tar) ("-o" + $install_dir)
.\7za x ($sdl2_ttf_dir   + $tar) ("-o" + $install_dir)

.\7za x ($sdl2_binding_dir       + $zip) ("-o" + $install_dir)
.\7za x ($sdl2_image_binding_dir + $zip) ("-o" + $install_dir)
.\7za x ($sdl2_mixer_binding_dir + $zip) ("-o" + $install_dir)
.\7za x ($sdl2_ttf_binding_dir   + $zip) ("-o" + $install_dir)

.\7za x ($gettext_dir    + $zip) ("-o" + $pkg_config_dir)
.\7za x ($glib_dir       + $zip) ("-o" + $pkg_config_dir)
.\7za x ($pkg_config_dir + $zip) ("-o" + $pkg_config_dir)

$client.DownloadFile($sdl_header_url, $sdl2_dir + $target_dir + "\include\SDL2\SDL_platform.h")

# Cleanup
Remove-Item ($sdl2_dir       + $tar_gz) -recurse
Remove-Item ($sdl2_image_dir + $tar_gz) -recurse
Remove-Item ($sdl2_mixer_dir + $tar_gz) -recurse
Remove-Item ($sdl2_ttf_dir   + $tar_gz) -recurse

Remove-Item ($sdl2_dir       + $tar) -recurse
Remove-Item ($sdl2_image_dir + $tar) -recurse
Remove-Item ($sdl2_mixer_dir + $tar) -recurse
Remove-Item ($sdl2_ttf_dir   + $tar) -recurse

Remove-Item ($sdl2_binding_dir       + $zip) -recurse
Remove-Item ($sdl2_image_binding_dir + $zip) -recurse
Remove-Item ($sdl2_mixer_binding_dir + $zip) -recurse
Remove-Item ($sdl2_ttf_binding_dir   + $zip) -recurse

Remove-Item ($gettext_dir    + $zip)  -recurse
Remove-Item ($glib_dir       + $zip)  -recurse
Remove-Item ($pkg_config_dir + $zip)  -recurse

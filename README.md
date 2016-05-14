# sdl2-hs-windows

This project lets you get sdl2 and its helper packages setup with stack on
windows relatively painlessly.

* First, you should get [7zip](http://www.7-zip.org/download.html) if you
don't yet have it. Make sure its path, which contains its binary 7z.exe
(default is "C:\Program Files\7-Zip"), is located in your PATH. It's needed
for the next step.

* Next you run `sdl-files-fetcher.ps1`, which is a PowerShell script. This
downloads and unpacks all the needed files into `C:\sdl`, and cleans up the
leftover archives once things are unpacked.

  * Note that this step (and the first step) only need to be done once per
system, so it's kept as a seperate script from the next script.

* To install the sdl2 libraries, you'll need to run the `path-setup.bat` to
add the proper directories to your current shell's path. Then just use stack
build. The stack.yaml file included already points to the correct git repos
and sets the correct flags. Every time you want to install the stack libraries
you'll need to run the `path-setup.bat` file first, but unless you're deleting
your `.stack-work/` directory a lot then this shouldn't be too often.

* If it was all successful, you should be able to `stack exec demo`, and have
a window filled with blue appear (it closes when you press 'q').

Note that you can change the location that things get unpacked to in the
`sdl-files-fetcher.ps1` script, but if you do you'll have to update the
`path-setup.bat` script yourself to have it point to the correct new
locations.

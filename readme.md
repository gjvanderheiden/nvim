# Intention of this repo:

This is just my config I use, so I use this as version control. The setup I'm using is for basic system maintanace / primary text editor as wel as a PDE / IDE. I now use it for Java and lua. So this might be another example how to setup jdtls-nvim. Looking for a one stop clicky click solution? This is not it. Want to know and control how your nvim works? You might pick something up here, that would be nice.

Maybe I'll do a seperate thing for just Java setup. Lua was pretty straight forward compared to Java with nvim-jdtls. But it does some great stuff.

but I also want to use it for Python, C++/C, CMake. , and Swift

I wanted to learn vim motions and the basics, because I really started to dislike I could just do some basic editing and
felt like a real PHEW moment when I succesfully edited and saved a file, especially on the server. I then start to like the way
the vim motions work and thought, what if I set my CLion, IntelliJ and PyCharm to the vim editor. Now I have a editor with keybindings wich are the same over multiple platforms AND I can move fast, without touching the mouse. This just grew out of hand... I started using nvim more and more, to the point I really want to use it as my primary IDE.

I do not like spring or springboot one bit. So I do not focus on springboot stuff. Don't care for it, never have.

I do wan't to explore more languages, but I'm starting with Java, because I'm formiliar with Java and not with nvim plugins, lua, lsp's etc. I'm used to IntelliJ. It just works. Not so much with nvim.

It is not ment as a config as is for everybody, but maybe this can serve as a sort of gist. Yank, Paste and Change Word all you like.
There are some Nvim distrobutions that handle a lot, and I use them so see what's around and what I like. Also I'm in the proces of setting up my keybindings. I like the <leader> r r for refactor->rename type of thing.

# Setup
I do not use Mason, as I like to use system package managers on my favourate OS-es, being MacOs (with homebrew) and Arch Linux (pacman).

## Needed packages
lsp-language-server
stylua
jdtls (AUR on Arch)

# Java config in nvim
It took me a while to find out how this works out. First I tried Java support using lazynvim, which worked to some extend. Then I found a repo which says Java plug and play, which is just a grabbag of plugins with some glue code.
This is just a summary of what I've found
The is a lot to take in when you starting out with language support in nvim. In nvim has adopted the LSP, short for Language Server Protocol. Which is a protocol that blablabla see the internet. Then there are the following components:
- Eclipse jdtls, the language server itself
- nvim-jdtls, wrapper to attach Eclipse jdtls 
- nvim-lspconfig, pops up when googling around on this topic, but do no use for jdtls!

# jdtls config
## Do not use nvim-lspconfig for Java / jdtls
It is possible to use nvim-lspconfig to connect start jdtls, but this doesn't make full use of [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls). It is in the readme of nvim-jdtls, but to me is was not that ovbious. Instead, ONLY configure nvim-jdtls to attach on Java files in nvim.

## How to hook up nvim-jdtls
### Install Eclipse jdtls
You van use mason to do this, I use my OS for this. Especially on Arch linux, it's a rolling release distro. On MacOs you have [home brew](https://brew.sh). Both are so quick with updates, amazing work. On homebrew and pacman the package is called jdtls. On Arch it is a AUR package. For Homebrew that's just:
```
brew install jdtls
```

If you're using yay on Arch Linux
```
yay -S jdtls
```

### Add jdtls as a plugin
I use [lazyvim](https://github.com/folke/lazy.nvim) as package manager for nvim. It allows to make nice separate lua files for installing. But whatever. Just add it. [My version is here](https://github.com/gjvanderheiden/nvim/blob/main/lua/plugins/jdtls.lua)
```
return {
 "mfussenegger/nvim-jdtls",
}
```

### Attatch on opening a java file JavaType
This took some digging. The readme on nvim-jdtls tells you to use ftplugin. Though this might work somehow, I used an autocommand, that nicked that nice idea from [here](https://github.com/Alexis12119/nvim-config). If you don't know what an autocommand is, it's worth to have a look. Basically it's events with listeners. The autocommand listen to opening a buffer wioth a specific file type, Java in this case, and than we call jdtls.start_or_attach() and off we go. 

Also we add some Java specific keybindings on the attach, so we have the key bindings when nvim it actually using the Java language server.
[I do that in this scipt](https://github.com/gjvanderheiden/nvim/blob/main/lua/config/autocommands/jdtls.lua). The scripts also does something with bundles, that is for the next section DAP & Test.

I do not use use the java command directly as on the Readme page of nvim-jdtls, but I use the jdtls executable which does everything I need.

The general keybindings are in a [seperate script](https://github.com/gjvanderheiden/nvim/blob/main/lua/config/autocommands/lsp-keymaps.lua). This autocommand listens to LspAttatch.

Now If you open a Java file, jdtls should run. You can verfiy with
```
:LspInfo
```
in nvim with a Java file opened.

#### DAP (debugging in nvim)  & Test
To be able to run tests within NeoVim, we need to add some more stuff. Just like the LSP config, the plugin nvim-jdtls does not make use of a configuring plugin like nvim-dapconfig and you do not need to define dap.adapters.java, as nvim-jdtls does that for you. You do need to add bundles to the config of jdtls via the nvim-jdtls plugin. It expects a lua table with full path .jar files. I've installed those in /opt/jdtls-bundles on my machine. In that directory I have java-debug and java-test directory, which contains the jars. The jars are extraced from the vscode plugins, because somehow mickeysoft thinks it is a good idea to put ever changing directory names in the plugin source. Now idea. So download the vs-code plugins, extract the jars, put this extention/server contents in /opt/jdtls-bundles/java-debug and /opt/jdtls-bundles/java-test directory. Then add them to the options.
This is done in the function get_bundles() which is called in the options table. [seperate script](https://github.com/gjvanderheiden/nvim/blob/main/lua/config/autocommands/jdtls.lua)

In order to run a class with a Java main method, jdtls needs a call:
```
require('jdtls.dap').setup_dap_main_class_configs()
```

This function only works when the lsp is running. In order to do that I added an [autocommand on LspAttatch](https://github.com/gjvanderheiden/nvim/blob/main/lua/config/autocommands/lsp-jdtls-dap.lua), which calls this function. Not really sure that's correct, but it seems to work.

## Missing functionality
There is a lot nvim with a bunch of plugins can do. But I'm missing the following:
- Browse project package. (not dirs, packages) Would like that with NavBuddy
- Run all tests, with a summary green of it it must, red
- Build
- maven editing support, dependency completion I miss the most
## Missing functionality, just not added yet
- Maybe attach jdtls on the start of a project / workspace or something. Now jdtls starts when any of the Java files are opened. 

# Java LSPs
https://github.com/georgewfraser/java-language-server
https://github.com/eclipse-jdtls/eclipse.jdt.ls

# Config and howto used
https://github.com/Alexis12119/nvim-config


# vimside

Vim Scala IDE (VimSIde) built upon ENSIME

----

# Introduction

This is an alpha release of Vimside, a Vim Scala IDE.
Most of the ENSIME capabilities have been implemented and 
but it has only been tested against the
very small Scala/Java test source project bundled with it.

Two outstanding Ensime features to be implemented are more
regression tests and debugging.

I added variable at bottom of the plugin/vimside.vim file
which allows one to turn on logging during Vimside Option
loading. For the Vimside logger, Options must first be loaded 
in order to configure it. Thus, no logging when loading Options.
So, I added a non-configurable logger that only logs in the
vimside#options#manager.vim file. Hopefully, this will help
users figure out whats happening during option loading.

Also, the example project code has been moved under the directory
data/vimside/projects - since there are now two example projects
and will be a couple more in the future. Additionally, the tests
have been moved under data/vimside/tests. I will be adding more
unit/regression tests in the future.

With lastest checkin, there is the first cut of the Type and 
Package Inspector. There will certainly be bugs. 
For types, place cursor over type and enter \<Leader>ti.
For package, place cursor over package path and enter \<Leader>tp.
Do not know if the project package inspector works yet.

Inspector keymaps:

    <Leader>ti   inspect type (cursor over type)
    <Leader>tp   inspect package (cursor over package path at top of file)
    <Leader>to   inspect project package 

Inspector control:

    In inspector pressing <F1> gets help.
    <Leader> q      : quit
    <Leader> <CR>   : inspect type at point
    <Leader> <TAB>  : next type
    <Leader> <C-n>  : next type
    <Leader> <S-TAB>: previous type  (S-TAB may not work)
    <Leader> <C-p>  : previous type
    <Leader> n      : next history
    <Leader> p      : previous history

Entering and leaving Type Inspector multiple times has not been
tested very much.

There is now included support for SBT (simple build tool).
The test project is in the data/tests/sbt directory. The
plugin/vimside.vim file has key mappings for functions that
start, compile, clean, package and exit from the SBT.

I have checked the source into github primarily so that
the source is somewhere other than on my local machines.
I expect to continue to update the sources on github
frequently, flushing out the features.

###Current Supported Ensime Commands:
|feature|description|implementations|
|-------|-----------|---|
|Start Ensime|makes sure that the current environment and Option settings are correct and then launches the Ensime backend server. The Ensime server writes a file where it puts the socket port that its client should use. Vimside reads that file, gets the port number, and provides Ensime with configuration information.|1|
|Stop Ensime|There is also an autocmd that will kill the Ensime server when the user exists Vim.|1|
|Map `<Tab>` to Omni-Code Completion in insert mode|This mapping maybe overridden by the mapping is some other plugin (like a snipmate binding), So, if it does not seem to work for you list the current mappings and see what is overriding it. Very Useful.|1|
|Symbol At Point|With cursor on variable, jump to the definition of its symbol. One can easily jump back and forth. The Emacs key binding uses the Meta key. In GVim I could get this to work and so in GVim the key mapping mirrors the Emacs Ensime key binding. But, with Vim in an XTerm, I could not get the Meta/Alt key to be recognized (and there is NO single place where there is a definitive, failsafe guide for getting Meta/Alt key mappings to work, so I have a different binding for Vim. Very useful.|1|
|Selection Expand/Contract|Select the surrounding syntactic context and easily shrink/grow the selection.|2|
|Global Public Search|Search for method or types through project code using space separated search terms. Useful.|1|
|Hover To Symbol|Place cursor (or mouse) over a variable and its Symbol will be displayed. Cute but requires frequent server polling.|3|
|Open Browser Info|With cursor over Scala/Java variable, type, etc. invoke the associated on-line web api documentation (if it exists). Useful.|1|
|Use of Symbol At Point|List all references to the symbol under the cursor. Very useful.|1|
|Simple Build Tool|Switch to the sbt command-line (works for sbt projects only)|2|
|Launch Repl|Switch to the Scala interpreter, with project classes in the classpath. TBD: cut/paste code fragments into Repl.|1|
|Typecheck Current File|Typecheck the current file and display errors and warnings. Very useful.|1|
|Typecheck All Files|Typecheck the all files and display errors and warnings. Very useful.|1|
|Re-Show Errors/Warnings|Show all errors and warnings in the project. Very useful.|1|
|Format Source|Format the current Scala source file. Useful.|1|
|Refactoring|Rename the symbol at point. Organize imports. Extract local. Extract method. Inline local. Add import for type at point. Import suggestions. Useful.|1|
|Building|Build the entire project. Rebuild the project incrementally. Useful.|1|
|Popup Menu|Bring up Popup menu with all Vimside commands (requires Forms library). Useful for folks who have not yet learned the key mappings.|1|
|Browse Source Roots|Directory browser of project sources (project code base).|2|
|Browse Reference Source Roots|Directory browser of project reference sources (Java and Scala libraries).|2|
|Option Viewer/Editor|Bring up the Option Viewer/Editor (requires Forms library). Lets one see all of the Vimside configurable Options and their current value. To be implemented will be an Editor allowing for the modification of some "dynamic" Options at runtime.|1|
|Completions|OmmiCompletions using `<c-x><c-o>`.Very Useful.|1|
|Package Inspector|Inspect imported package, current file's package and the package specified in the ensime configuration `:package`. Very Useful|1|
|Type Inspector|Click on type and see information, Click on information and see its information. Move about Inspector history. In Inspector help <F1>. Very Useful|1|

###Ensime Capabilities to be Supported:
|feature|description|
|---|---|
|Scalex|Seems to be a dead project (see: http://scalex.org/)|
|Run Application||
|Debug Application|Start and run the debugger. Start and run the debugger. Set a breakpoint. Clear a breakpoint. Step. Step over. Step out. Continue from a breakpoint. Kill the debug session. Inspect the local variable at cursor. Show backtrace.|
|Others...||

----
# Installation

## Download

One can download a zip snapshot or use a Vim plugin manager (such
as VAM).

## Dependency

Vimside depends upon Vimproc 
[GitHup]( https://github.com/Shougo/vimproc)
for a C-language binding to sockets
(and, thus to the Ensime server) and Vimshell 
[GitHup]( https://github.com/Shougo/vimshell)
for launching and managing communications with the Scala Repl.


## Vimside Directory layout

After unpacking the Vimside directory layout should look like:

    $HOME/.vim/
      autoload/
        vimside.vim
        vimside/
          " vimside code
      data/
        " data that persists between invocations of a plugin
        vimside/
            " examples, local test Scala/Java source tree
      doc/
        vimside.txt
      plugin/
        vimside.vim

## Intalling from Vim.org

Anyway, to get the Vimside zip file from vim.org go to
http://www.vim.org/scripts/script.php?script_id=4298
and download the latest version. Unzip it in your `.vim` or `vimfiles`
directory.


Now, Vimside depends upon Vimshell and Vimproc.  It is recommended that 
you get the latest releases of these since they both were modified to add
some support for capabilities identified while creating Vimside. They are
located at:
[Vimproc](https://github.com/Shougo/vimproc)
[Vimshell](https://github.com/Shougo/vimshell)
Download them both and unzip them.

For Vimproc, there is an additional step because it includes a C-language 
library. You must compile the library for your machine.  Vimproc comes with 
a number of make-files. Pick the right one and build the library. Since 
Vimside is for Scala programmers, I expect that building a C-library with 
a supplied makefile will not be too challenging :-)

In addition, Vimside can be configured so that it can use the Vim
Forms and Self libraries. The latest version of these can be gotten
from github or you can get released versions from vim.org:
[Self](http://www.vim.org/scripts/script.php?script_id=4150)
[Forms]( http://www.vim.org/scripts/script.php?script_id=3072)

For most of the Vimside commands there are associated Options that configure 
how the command can be used. Many such Options allow the user to run one 
of multiple possible implementations.  In particular, there might be a 
"native" Vim, non-Forms-based solution and also a Forms-based solution. The 
Forms-based solution is built upon "native" Vim but requires the downloading 
of the above two libraries: Self and Forms. Each such command with multiple 
implementations can be configure individually to use or not use Forms.

What's more, the Forms library allows one to used a popup menu
(useful if you do not know all of the Vimside key-mappings yet).
And, it is expected that the package-inspector and the type-inspector
will only have Forms implementations - how to do a type-inspector
otherwise might be a challenge.

## Intalling with vim-addon-manager (VAM)

For more information about vim-addon-manager, see 
[vim-addon-manager](https://github.com/MarcWeber/vim-addon-manager) and 
[Vim-addon-manager getting started](https://github.com/MarcWeber/vim-addon-manager/blob/master/doc/vim-addon-manager-getting-started.txt)

In your `.vimrc`, add self as shown below:

    fun SetupVAM()

      ...

      let g:vim_addon_manager = {}
      let g:vim_addon_manager.plugin_sources = {}

      ....

      let g:vim_addon_manager.plugin_sources['self'] = {'type': 'git', 'url': 'git://github.com/megaannum/self'}
      let g:vim_addon_manager.plugin_sources['forms'] = {'type': 'git', 'url': 'git://github.com/megaannum/forms'}
      let g:vim_addon_manager.plugin_sources['vimproc'] = {'type': 'git', 'url': 'git://github.com/Shougo/vimproc'}
      let g:vim_addon_manager.plugin_sources['vimshell'] = {'type': 'git', 'url': 'git://github.com/Shougo/vimshell'}
      let g:vim_addon_manager.plugin_sources['ensime'] = {"type": "git", "url": "git://github.com/aemoncannon/ensime", "branch" : "scala-2.9"}
      let g:vim_addon_manager.plugin_sources['vimside'] = {'type': 'git', 'url': 'git://github.com/megaannum/vimside'}


      let plugins = [
        \ 'self',
        \ 'forms',
        \ 'vimproc',
        \ 'vimshell',
        \ 'ensime',
        \ 'vimside'
        \ ]

      call vam#ActivateAddons(plugins,{'auto_install' : 0})

      ...

    endf
    call SetupVAM()


Note that to use Vimside, the `self` and `forms` libraries above are
optional. With the `forms` library, Vimside supports additional 
features such as a popmenu of commands and the type and package inspectors
(not yet implemented).

Also, when one downloads Vimproc, you MUST go into the vimproc
directory and build the C-language file `proc.c` using one of the
supplied make files.

Now start Vim. You will be asked by vim-addon-manager 
if you would like to download and install the plugins.

## Installing with pathogen

With pathogen, you just have to clone all required plugins into your `~/.vim/bundle directory`. Running the following lines as a bash script will do exactly that.


    #!/bin/bash

    declare -a repos=( 
      "git://github.com/megaannum/self.git" 
      "git://github.com/megaannum/forms.git" 
      "git://github.com/Shougo/vimproc.git"
      "git://github.com/Shougo/vimshell.git"
      "-b scala-2.9 git://github.com/aemoncannon/ensime.git"
      "git://github.com/megaannum/vimside.git"
    )

    cd ~/.vim/bundle
    
    for repo in "${repos[@]}"; do
        git clone $repo 
    done;

Note that you also with pathogen have to run `make` on the appropriate make file inside the vimproc plugin directory.

## Installing with Vundle

Vundle does not provide specific branch checkout yet. Thus after adding:
    
    Bundle "megaannum/self"
    Bundle "megaannum/forms" 
    Bundle "Shougo/vimproc"
    Bundle "Shougo/vimshell"
    Bundle "aemoncannon/ensime"
    Bundle "megaannum/vimside"    

You need to check out appropriate ensime branch by hand by running ie.

    > git checkout scala-2.10
    
in ensime plugin directory managed by vundle (probably `~/.vim/bundle/ensime`).
Also you'll need to run `make` in vimproc directory.

----

## Ensime Install

###[Download](https://github.com/aemoncannon/ensime)  
###[Manual](http://aemoncannon.github.com/ensime/index.html/)

In addition, for ENSIME, there are pre-built releases available at: 
https://www.dropbox.com/sh/ryd981hq08swyqr/V9o9rDvxkS/ENSIME%20Releases
I highly recommend getting these (Scala 2.9.2 and/or 2.10.0)
rather than trying to build the Ensime Scala code yourself.

Ensime is not a Vim plugin. It is a Scala program. It has to be installed and built or a pre-build version has to be used. Its source can be downloaded from: https://github.com/aemoncannon/ensime

One can the follow the instructions there and build it. 

I have never done this. Rather, I have downloaded a pre-build bundle. One for Scala 2.9 and another for Scala 2.10.0. These can be found at:
https://www.dropbox.com/sh/ryd981hq08swyqr/V9o9rDvxkS/ENSIME%20Releases

The Ensime build directory has the following layout using
`ensime_2.9.2-0.9.8.9` as an example:

    ensime_2.9.2-0.9.8.9/
        bin/                 
        LICENSE
        elisp/
        lib/                 
        README.md

or `ensime_2.10.0-0.9.8.9`:

    ensime_2.10.0-0.9.8.9/
        bin/  
        elisp/  
        lib/  
        LICENSE  
        README.md

It is important that the value of the `vimside-scala-version`
Option agrees with the Ensime build version. For
`ensime_2.9.2-0.9.8.9` (the default value):
    call owner.Set("vimside-scala-version", "2.9.2")
and for `ensime_2.10.0-0.9.8.9`:
    call owner.Set("vimside-scala-version", "2.10.0")

These values can be set in `data/vimside/options_user.vim`.

In addition, the version of Java (`$JAVA_HOME/bin/java -version`)
in the window  that runs Vim (or launched GVim) must agree with
the value of the Option `vimside-java-version`. This Option
has the default value of `1.6` and can be set, again, in
`data/vimside/options_user.vim`: 
    call owner.Set("vimside-java-version", "1.6")

Having built Ensime or downloaded a pre-built package, you must
set an Option in Vimside so that Vimside can locate the script
used to start the Ensime server. To set a Vimside Option, you
must copy the `example_options_user.vim` located in
`data/vimside` to a file called `options_user.vim` and
edit it.

There is two different ways to do this.

The first is to set the Option `ensime-install-path` to the
location of downloaded Ensime source. If you use the VAM plugin manager,
then Ensime will be in the directory: `$HOME/.vim/vim-addons/ensime` 
or `$HOME/vimfiles/vim-addons/ensime` so you would set the Option accordingly:
    
    call owner.Set("ensime-install-path", $HOME . "/.vim/vim-addons/ensime")
    
or 

    call owner.Set("ensime-install-path", $HOME . "/vimfiles/vim-addons/ensime")`

If installed with pathogen, those paths are `$HOME/.vim/bundle/ensime` or `$HOME/vimfiles/bundle/ensime`

Then depending upon the name of the build directory, which is under the
`ensime-install-path` Option value directory location, you would
set the value of the Option `ensime-dist-dir` to that directory name.
For example:

    call owner.Set("ensime-dist-dir", "ensime_2.9.2-0.9.8.9")
    
or 
    call owner.Set("ensime-dist-dir", "ensime_2.10.0-0.9.8.9")

Alternatively, you can specify the full path to the ensime distribution
using the Option `ensime-dist-path`. As an example, if you installed
an Ensime build package in some Scala directory, you might set
the Option as: 

    call owner.Set("ensime-dist-path", $HOME . "/scala/ensime/ensime_2.9.2-0.9.8.9")`

If you set the `ensime-dist-path`, it is checked first and if it exists it
is used rather than the `ensime-install-path` and `ensime-dist-dir` combination.

With SBT support, there is a SBT Plugin that supports integration with 
the ENSIME IDE:
https://github.com/aemoncannon/ensime-sbt-cmd
Follow the directions there and add

    addSbtPlugin("org.ensime" % "ensime-sbt-cmd" % "VERSION")

to your ~/.sbt/plugins/plugins.sbt file
Where "VERSION" it the version of Ensime supported which, as 
the ensime-sbt-cmd README.md states, is 0.1.1. So, the above 
should be:

    addSbtPlugin("org.ensime" % "ensime-sbt-cmd" % "0.1.1")

Entering "ensime generate" while running sbt does indeed
generate a ".ensime" file. I have not tested whether or not
that generated file can actually be used by Vimside and
passed to the backend Ensime server.

----

# Usage

Look at the plugin/vimside.vim file for key mappings: how to
start the Ensime server and the currently supported commands.

RECOMMENDED for initial testing:
To run against test Scala/Java project, first in data/vimside directory
copy `example_options_user.vim` to `options_user.vim`.

    > cd $HOME/.vim/data/vimside
    > /bin/cp example_options_user.vim options_user.vim

Then, in `options_user.vim` uncomment the following two lines:

    call a:option.Set("test-ensime-file-use", 1)
    call a:option.Set("ensime-config-file-name", "ensime_config.vim")

This tells Vimside to use the test project code and to use the
ensime_config.vim as the source for Ensime Configuration.

If one want to have one or more projects then one will most likely
want to have project specific Vimside configuration capabilities.
There is an Option for that.

There is a single file to configure Vimside Options under `.vim`, 
`data/vimside/options_user.vim`. This is sufficient if you only have
a single project on your machine. But, if you have or plan to have more
than one projects on your machine you might want to have project
specific option configuration files. There are two Options that 
control this.

The first Option is: `vimside-project-options-enabled` and if 
true (default is false), then Vimside will look for a configuration
file with name given by the second Option: `vimside-project-options-file-name`.

The default value of the `vimside-project-options-file-name` Option
is `options_project.vim`.

While in the `options_user.vim` file, an Option value is set using
the `Set` function, e.g,:

    call owner.Set("vimside-scala-version", "2.9.2")

In the `options_project.vim` file, the Option Update function must be used:

    call owner.Update("vimside-scala-version", "2.10.0")

This is because `Set` can only be called once per-Option (while, `Update`
can be called any number of times).

So, in the `options_user.vim` one might have:

    call owner.Set("vimside-scala-version", "2.9.2")
    call owner.Set("ensime-dist-dir", "ensime_2.9.2-0.9.8.9")
    call owner.Set("ensime-config-file-name", "ensime_config.vim")

in a project file there might be:

    call owner.Update("vimside-scala-version", "2.10.0")
    call owner.Update("ensime-dist-dir", "ensime_2.10.0-0.9.8.9")
    call owner.Update("ensime-config-file-name", "_ensime")

An alternative approach is to also treat the `data/vimside/` test code
as also a project, in that, it has its own `options_project.vim` file.
To do this one must do the following:

1) In the `options_user.vim` file enable project local options files:

    call owner.Set("vimside-project-options-enabled", 1)

While one can also uncomment/add addition option value setting,
if one wants all projects to share some behavior or to set some
default behavior (which can be over-ridden on a project-by-project
basis), but enabling the above Option is all that is need in this file.

2) In the `data/vimside` directory create a `options_project.vim` such as:

    " full path to this file
    let s:full_path=expand('<sfile>:p')

    " full path to this file's directory
    let s:full_dir=fnamemodify(s:full_path, ':h')

    function! g:VimsideOptionsProjectLoad(owner)
      let owner = a:owner

      "--------------
      " Enable logging
      call owner.Set("ensime-log-enabled", 1)
      call owner.Set("vimside-log-enabled", 1)
      "--------------

      "--------------
      " Defined Java versions: '1.5', '1.6', '1.7'
      " Defined Scala versions: '2.9.2', '2.10.0'
      " Minor version numbers not needed
      " Scala version MUST match 'ensime-dist-dir' used.
      call owner.Set("vimside-java-version", "1.6")
      call owner.Set("vimside-scala-version", "2.9.2")
      "--------------
      
      "--------------
      " Which build version of Ensime to use. 
      call owner.Set("ensime-dist-dir", "ensime_2.9.2-0.9.8.9")
      "--------------

      "--------------
      " To run against ensime test project code
      " Location of test directory
      call owner.Set("test-ensime-file-dir", s:full_dir)
      " Uncomment to run against demonstration test code
      call owner.Set("test-ensime-file-use", 1)
      " The Ensime Config information is in a file called 'ensime_config.vim'
      call owner.Set("ensime-config-file-name", "ensime_config.vim")
      "--------------

      "--------------
      " Vimside uses Forms library 
      call owner.Set("forms-use", 1)
      "--------------

      "--------------
      " Hover Options
      call owner.Set("vimside-hover-balloon-enabled", 0)
      call owner.Set("vimside-hover-term-balloon-enabled", 0)
      "--------------
    endfunction

This will instruct Vimside to use the "test" source code and configuration
files.

3) In all your other projects on this machine, create their own 
project-specific 'options_project.vim' files.

This is a very flexible way of configuring Vimside.

----

# Supported Platforms

Ought to work most everywhere

----

## Tutorial

None available yet.

----

## Acknowledgements and thanks

Aemon Cannon for writing Ensime!
Daniel Spiewak has a JEdit binding to Ensime and a simply great video
explaining why a true editor with Ensime is better than an Eclipse 
Ide (https://www.youtube.com/watch?v=cd2LV0xy9G8 MUST SEE) 
and usage examples (http://vimeo.com/28597033).

Jeanluc Chasseriau who wrote the python-based Envim Vim binding
to Ensime: https://github.com/jlc/envim.

Sven Eigenbrodt provided the Pathogen installation information.

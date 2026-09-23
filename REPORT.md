# Operating Systems - Feature 1 Report

## Feature 1: Project Scaffolding and Version Control

This feature focuses on creating the project structure using Linux shell commands and managing the project using Git and GitHub.

## Project Structure

The project contains the following directories:

- src/
- include/
- lib/
- bin/
- obj/

A REPORT.md file is also included for documenting the project.


## Feature 2 implements a multi-file C project with automated compilation using a Makefile.
The project separates string functions, file functions, and the main program into different source and header files.

The Makefile compiles the source files into object files and links them together to generate the final executable:

bin/client

A Git branch named multifile-build is used to develop the feature. After successful testing, the changes are committed and an annotated Git tag is created to identify the completed version.

Finally, a GitHub Release is created for this version, with the compiled client executable attached as a binary so that the program can be downloaded and used without recompiling the source code.

## Feature 3 
Key differences:

New archiving step: the utility object files are first bundled into libmyutils.a using ar, rather than being linked in directly.
main.o is separated from the library object files — it's compiled on its own and only later linked against the library.
New variables/flags appear: -L (tells the linker which directory to search for libraries) and -l (tells the linker which library to link, by name, without the lib prefix or .a suffix).
The final link rule no longer lists every .o file individually — it depends on main.o and the archive, which is a single reusable unit.

Conceptually: Part 2 treats all source files as one flat compilation unit, while Part 3 introduces modularity — the utility code becomes a standalone, reusable component that any future program could link against, not just this one main.c.

2. Purpose of ar, and why ranlib is used after it

ar (archiver) bundles multiple .o object files into a single archive file (.a), which acts as a static library. It's essentially a container/package format — it doesn't compile or link anything, it just packs object files together (similar in spirit to a .zip, but for object files).

ranlib generates (or regenerates) an index of the symbols defined in the archive and stores it inside the archive itself. This symbol index lets the linker quickly determine which archive member defines a given symbol, instead of scanning every object file in the archive linearly.

In practice you often don't need to run ranlib separately, because the s flag in ar rcs already tells ar to create that symbol index as part of the archiving step (r = insert/replace files, c = create archive if it doesn't exist, s = write the index). So ar rcs libmyutils.a *.o does the job of both ar and ranlib in one command. If you use ar rc without s, you'd need to run ranlib libmyutils.a afterward, or the linker may fail to find symbols efficiently (some modern linkers tolerate a missing index and rebuild it themselves, but it's not something to rely on).

3. Are mystrlen symbols present in client_static? What does this tell you about static linking?

Yes — when you run:

bash
nm bin/client_static | grep mystrlen

you should see something like:

0000000000401136 T mystrlen

The T means the symbol is defined and present in the text (code) segment of the executable itself.

This demonstrates the defining characteristic of static linking: the linker copies the actual machine code of every function you use (like mystrlen) out of the archive and embeds it directly into the final executable at link time. The library isn't referenced externally at runtime — it becomes part of the binary. That's why:

client_static doesn't need libmyutils.a to be present anywhere when you run it later, and
the executable is larger than a dynamically-linked equivalent, since it physically contains that code rather than just a reference to it.

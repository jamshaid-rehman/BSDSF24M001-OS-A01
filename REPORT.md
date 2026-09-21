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


Feature 2 implements a multi-file C project with automated compilation using a Makefile. The project separates string functions, file functions, and the main program into different source and header files.

The Makefile compiles the source files into object files and links them together to generate the final executable:

bin/client

A Git branch named multifile-build is used to develop the feature. After successful testing, the changes are committed and an annotated Git tag is created to identify the completed version.

Finally, a GitHub Release is created for this version, with the compiled client executable attached as a binary so that the program can be downloaded and used without recompiling the source code.

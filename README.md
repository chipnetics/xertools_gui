![image](assets/logo.png)
# Graphical Interface for Primavera XER Tools

A graphical front-end for the XERtools toolkit which can be found [here](https://github.com/chipnetics/xertools).

# Project Motivation

For users who are not very comfortable with the command line, or don't need to automate execution of the toolkit executables with batch scripts and prefer to run things visually.

---

## Compiling

The graphical frontend is written in Dart + Flutter.

### Clone this repository

`git clone https://github.com/chipnetics/xertools_gui.git`

### Download Flutter + Dart SDK

`https://docs.flutter.dev/get-started/install`

### For building in Windows, you need Visual Studio with "Desktop Development with C++" workload installed (~8GB)

*NB: Visual Studio Community edition is sufficient.*

`https://visualstudio.microsoft.com/`

### For building in Linux, typical gcc toolchain...

`sudo apt install build-essential` (or similar, depending on flavor)

### Compile with flutter with the appropriate command line options...

#### Building in Linux environment
`flutter build linux`

#### Building in Windows environment
`flutter build windows`
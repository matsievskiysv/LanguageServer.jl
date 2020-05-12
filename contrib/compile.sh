#!/usr/bin/env bash

JULIABIN="julia"
JULIAPROJ="JuliaLSP"
JULIACOMP="JuliaLSP_compiled"

BRANCH="master"

RED='\033[0;31m'
NC='\033[0m'

while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        -j|--julia)
            JULIABIN="$2"
            shift
        ;;
        -b|--branch)
            BRANCH="$2"
            shift
        ;;
        *)
            echo -e "Usage:\ncompile.sh [-j|--julia <julia binary>] [-b|--branch <repo branch>]" >&2
            exit
        ;;
    esac
    shift
done

echo -e ${RED}Updating packages${NC}

$JULIABIN --startup-file=no --history-file=no -e \
          "import Pkg; Pkg.activate(\"${JULIAPROJ}\"); Pkg.add(Pkg.PackageSpec(url=\"https://github.com/julia-vscode/LanguageServer.jl\", rev=\"${BRANCH}\")); Pkg.update();" || exit

echo -e ${RED}Compiling...${NC}

$JULIABIN --startup-file=no --history-file=no -e \
          "import Pkg; Pkg.add(\"PackageCompiler\"); using PackageCompiler; create_app(\"${JULIAPROJ}\", \"${JULIACOMP}\", force=true);" || exit

echo -e ${RED}Compiled${NC}

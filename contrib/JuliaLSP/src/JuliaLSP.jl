module JuliaLSP

using LanguageServer
import SymbolServer

function julia_main()::Cint
    server = LanguageServer.LanguageServerInstance(stdin, stdout)
    server.runlinter = true
    run(server)
    return 0 # if things finished successfully
end

end # module

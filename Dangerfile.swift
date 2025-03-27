import Danger 
let danger = Danger()

let markdownFiles = danger.git.modifiedFiles.filter({ $0.hasSuffix(".md") })

if markdownFiles.count == 0, !markdownFiles.contains("README.md", where: { $0.lowercased() == "readme.md" }) {
    danger.fail("O README.md não foi modificado, conforme instruído no guia de contribuição.")
}

let storyboardFiles = danger.git.modifiedFiles.filter({ $0.hasSuffix(".storyboard")})

if storyboardFiles.count == 0, !storyboardFiles.contains("Main.storyboard", where: { $0.lowercased() == "main.storyboard" }) {
    danger.warn("O desafio da semana inclui mudanças no Main storyboard.")
}

guard let projectFile = danger.git.modifiedFiles.filter({$0.hasSuffix(".pbxproj")}).first else {
    danger.fail("O desafio da semana inclui alterar o deployment target para iOS 16")
    return
}

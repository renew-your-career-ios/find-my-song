import Danger 
let danger = Danger()

struct Grader {
    var danger: DangerDSL
    
    func checkContributionGuide() {
        let markdownFiles = danger.git.modifiedFiles.filter({ $0.hasSuffix(".md") })

        if markdownFiles.count == 0, !markdownFiles.contains(where: { $0.lowercased() == "readme.md" }) {
            danger.fail("O README.md não foi modificado, conforme instruído no guia de contribuição.")
        }
    }
    
    func checkChallengeNumberTwo() {
        let storyboardFiles = danger.git.modifiedFiles.filter({ $0.hasSuffix(".storyboard")})

        if storyboardFiles.count == 0, !storyboardFiles.contains(where: { $0.lowercased() == "main.storyboard" }) {
            danger.warn("O desafio da semana inclui mudanças no Main storyboard.")
        }

        guard let projectFile = danger.git.modifiedFiles.filter({$0.hasSuffix(".pbxproj")}).first else {
            danger.fail("O desafio da semana inclui alterar o deployment target para iOS 16")
            return
        }
    }
}

let grader = Grader(danger: danger)
grader.checkContributionGuide()
grader.checkChallengeNumberTwo()

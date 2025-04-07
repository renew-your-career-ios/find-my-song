import Danger

let danger = Danger()

struct Grader {
    var danger: DangerDSL
    
    func checkContributionGuide() {
        let markdownFiles = danger.git.modifiedFiles.filter({ $0.hasSuffix(".md") })

        if markdownFiles.isEmpty || !markdownFiles.contains(where: { $0.lowercased() == "readme.md" }) {
            danger.fail("O README.md não foi modificado, conforme instruído no guia de contribuição.")
        }
        if danger.git.modifiedFiles.filter({$0 == "Package.swift"}).first != nil {
            danger.warn("A modificação não solicitada do arquivo Package.swift é desencorajada.")
        }
        guard danger.git.modifiedFiles.filter({$0 == "CODEOWNERS"}).first == nil else {
            danger.fail("A modificação do arquivo CODEOWNERS é proibida.")
            return
        }
    }

    func checkPullRequestTemplate() {
        guard let pullRequestBody = danger.github.pullRequest.body else {
            danger.fail("O PR não possui descrição, conforme o modelo de PR sugerido.")
            return
        }
        
        let affirmativeUIChangeMarkdown = "- [X] Sim"
        let beforeScreenshotURLplaceholder = "Cole aqui como era..."
        let afterScreenshotURLplaceholder = "Cole aqui como ficou..."
        
        if (pullRequestBody.contains(affirmativeUIChangeMarkdown) && pullRequestBody.contains(beforeScreenshotURLplaceholder)) || (pullRequestBody.contains(affirmativeUIChangeMarkdown) && pullRequestBody.contains(afterScreenshotURLplaceholder)) {
            danger.warn("Mudanças de interface precisam ser documentadas no corpo do PR com screenshots antes e depois, conforme o modelo proposto")
        }
    }
    
    func checkConventionalCommits() {
        let commits = danger.git.commits
        let conventionalCommitRegex = try? Regex("^(BREAKING CHANGE|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\\([a-zA-Z0-9-_]+\\))?:!? .+")

        for commit in commits {
            let commitMessage = commit.message
            guard let regex = conventionalCommitRegex, !commitMessage.ranges(of: regex).isEmpty else {
                if !commitMessage.lowercased().contains("merge") {
                    danger.warn("O commit '\(commitMessage)' não segue as diretrizes do conventionalcommits.org.")
                }
                continue
            }
        }
    }
    
    func checkChallengeNumberTwo() {
        let storyboardFiles = danger.git.modifiedFiles.filter({ $0.hasSuffix(".storyboard")})

        if storyboardFiles.isEmpty, !storyboardFiles.contains(where: { $0.lowercased() == "main.storyboard" }) {
            danger.fail("O desafio da semana inclui mudanças no Main storyboard.")
        }

        guard danger.git.modifiedFiles.filter({$0.hasSuffix(".pbxproj")}).count > 0 else {
            danger.fail("O desafio da semana inclui alterar o deployment target para iOS 16")
            return
        }
    }
    
    func checkChallengeNumberThree() {
        let storyboardFiles = danger.git.deletedFiles.filter({ $0.hasSuffix(".storyboard")})

        if storyboardFiles.isEmpty || !storyboardFiles.contains(where: { $0.lowercased().contains("main.storyboard") }) {
            danger.fail("O desafio da semana inclui remover o Main storyboard.")
        }
        
        if danger.git.modifiedFiles.filter({$0.lowercased().contains("viewcontroller.swift")}).isEmpty {
            danger.fail("O desafio da semana necessariamente espera uma refatoração da ViewController.swift")
        }
        
        if danger.git.modifiedFiles.filter({$0.lowercased().contains("scenedelegate.swift")}).isEmpty {
            danger.fail("O desafio da semana inclui uma mudança no SceneDelegate.swift")
        }
        
        if danger.git.modifiedFiles.filter({$0.lowercased().contains("info.plist")}).isEmpty {
            danger.fail("O desafio da semana inclui remover referências ao main.storyboard da Info.plist")
        }
        
        guard !danger.git.modifiedFiles.filter({$0.hasSuffix(".pbxproj")}).isEmpty else {
            danger.fail("O desafio da semana inclui alterar o deployment target para iOS 17")
            danger.fail("O desafio da semana inclui remover referências ao main.storyboard do build settings")
            return
        }
    }
    
    func runChecks(args: () -> ()...) {
        for arg in args {
            arg()
        }
    }
}

let grader = Grader(danger: danger)
grader.runChecks(args:
                    grader.checkPullRequestTemplate,
                    grader.checkContributionGuide,
                    grader.checkChallengeNumberThree,
                    grader.checkConventionalCommits
                )

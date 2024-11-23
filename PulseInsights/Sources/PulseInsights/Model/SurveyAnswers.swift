//
//  SurveyAnswers.swift
//  PulseInsights
//
//  Created by long shen on 2024/5/22.
//  Copyright © 2024 Pulse Insights. All rights reserved.
//

import Foundation

struct SurveyAnswer: CustomStringConvertible, Encodable {
    var question_id: String = ""
    var question_type: String = ""
    var answer: String = ""

    var description: String {
        return "Question ID: \(question_id), Type: \(question_type), Answer: \(answer)"
    }
}

class SurveyAnswers: CustomStringConvertible  {
    var answers: [SurveyAnswer]

    init() {
        self.answers = []
    }
    
    var description: String {
        return answers.map { $0.description }.joined(separator: "\n")
    }

    func setAnswer(questionId: String, questionType: String, answer: String) {
        if questionType == "single_choice_question" || questionType == "free_text_question" {
            if answer.isEmpty, let index = answers.firstIndex(where: { $0.question_id == questionId }) {
                answers.remove(at: index)
                return
            } else {
                for (index, surveyAnswer) in answers.enumerated() {
                    if surveyAnswer.question_id == questionId {
                        answers[index].answer = answer
                        return
                    }
                }
            }
        } else if questionType == "multiple_choices_question" {
//            need to format 001&002 => 001,002
            let formattedAnswer = answer.replacingOccurrences(of: "&", with: ",")
            // let's say I already have a answer in answers, answers = [{questionId: "1", questionType: "multiple_choices_question", answer: "001"}]
            // After I click other question, I'll get a new answer input as "001&002"
            // After I click other question again, I'll get a new answer input as "001&002&003"
            // After I click the first question again, I'll get a new answer input as "002&003"
            // if the answer is empty, remove the question from answers

            if formattedAnswer.isEmpty, let index = answers.firstIndex(where: { $0.question_id == questionId }) {
                answers.remove(at: index)
                return
            } else {
                // if the answer is not empty, update the answer
                for (index, surveyAnswer) in answers.enumerated() {
                    if surveyAnswer.question_id == questionId {
                        answers[index].answer = formattedAnswer
                        return
                    }
                }
            }
        }
        answers.append(SurveyAnswer(question_id: questionId, question_type: questionType, answer: answer))
    }

    func getAnswers() -> [SurveyAnswer] {
        return answers
    }

    func isAnswered(questionId: String) -> Bool {
        for surveyAnswer in answers {
            if surveyAnswer.question_id == questionId {
                return true
            }
        }
        return false
    }

    func isEmpty() -> Bool {
        return answers.isEmpty
    }
}


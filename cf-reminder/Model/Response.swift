//
//  ContestList.swift
//  cf-reminder
//
//  Created by Erkhaan  on 03.11.2022.
//

import Foundation

// MARK: - ContestList

struct Response: Decodable {
    let result: [Contest]
}

// MARK: - Contest

struct Contest: Decodable {
    let id: Int
    let name: String
    let type: TypeEnum
    let phase: Phase
    let frozen: Bool
    let durationSeconds, startTimeSeconds, relativeTimeSeconds: Int
}

enum Phase: String, Decodable {
    case before = "BEFORE"
    case finished = "FINISHED"
    case pendingSystemTest = "PENDING_SYSTEM_TEST"
}

enum TypeEnum: String, Decodable {
    case cf = "CF"
    case icpc = "ICPC"
    case ioi = "IOI"
}

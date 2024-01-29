//
//  MemberListManager.swift
//  MemberList
//
//  Created by 예찬 on 1/18/24.
//

import Foundation

struct MemberListManager {
    private var membersList: [Member] = []
    
    mutating func makeMembersListData() {
        membersList = [
            Member(name: "배트맨", age: 30, phoneNumber: "010-1234-5678", address: "고담시티 1번지"),
            Member(name: "베조스", age: 57, phoneNumber: "010-1111-2233", address: "미국 뉴저지"),
            Member(name: "쿡", age: 62, phoneNumber: "010-1324-5768", address: "미국 라스베이가스"),
            Member(name: "스티브", age: 66, phoneNumber: "010-1221-2331", address: "미국 워싱턴DC"),
            Member(name: "홍길동", age: 22, phoneNumber: "010-1011-0100", address: "대한민국 서울"),
            Member(name: "임꺽정", age: 45, phoneNumber: "010-2468-3579", address: "대한민국 부산"),
            Member(name: "조커", age: 42, phoneNumber: "010-9876-5432", address: "고담시티 7번지")
        ]
    }
    
    func getMemberList() -> [Member] {
        return membersList
    }
    
    mutating func makeNewMember(_ member: Member) {
        membersList.append(member)
    }
    
    mutating func updateMemberInfo(index: Int, _ member: Member) {
        membersList[index] = member
    }
    
    // 서브스크립트 사용자 지정
    subscript(index: Int) -> Member {
        get {
            return membersList[index]
        }
        set {
            membersList[index] = newValue
        }
    }
}

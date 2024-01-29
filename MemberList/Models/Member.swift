//
//  Member.swift
//  MemberList
//
//  Created by 예찬 on 1/18/24.
//

import UIKit

protocol MemberDelegate: AnyObject {
    func addNewMember(_ member: Member)
    func updateMemberInfo(_ index: Int, _ member: Member)
}

struct Member {
    lazy var memberImage: UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    static var memberNumbers: Int = 0
    let memberId: Int
    var name: String?
    var age: Int?
    var phoneNumber: String?
    var address: String?
    
    init(name: String?, age: Int?, phoneNumber: String?, address: String?) {
        self.memberId = Member.memberNumbers
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
        self.address = address
        
        Member.memberNumbers += 1
    }
}

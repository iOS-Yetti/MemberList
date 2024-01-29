//
//  DetailViewController.swift
//  MemberList
//
//  Created by 예찬 on 1/19/24.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    
    // MARK: - Property
    private let detailView = DetailView()
    weak var delegate: MemberDelegate?
    var member: Member?
    
    // MARK: - Method
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureButtonAction()
        configureTapGesture()
    }
    
    private func configureData() {
        detailView.member = member
    }
    
    // 버튼은 UIView에 생성되어있지만 버튼의 액션은 VC에서 설정해줘야함
    // 이유: present 메서드가 UIView엔 구현되어 있지않고 VC에만 구현되어 있다.
    private func configureButtonAction() {
        detailView.saveButton.addTarget(self,
                                        action: #selector(saveButtonTapped),
                                        for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        if member == nil {
            // 새로운 멤버 추가
            let name = detailView.nameTextField.text
            let age = Int(detailView.ageTextField.text ?? "")
            let phoneNumber = detailView.phoneNumberTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            var newMember = Member(name: name,
                                   age: age,
                                   phoneNumber: phoneNumber,
                                   address: address)
            newMember.memberImage = detailView.memberImageView.image
            
            // 커스텀 델리게이트 패턴
            delegate?.addNewMember(newMember)
        } else {
            // 기존 멤버 업데이트
            let memberNumber = Int(detailView.memberNumberTextField.text ?? "") ?? 0
            member?.memberImage = detailView.memberImageView.image
            member?.name = detailView.nameTextField.text ?? ""
            member?.age = Int(detailView.ageTextField.text ?? "") ?? 0
            member?.phoneNumber = detailView.phoneNumberTextField.text ?? ""
            member?.address = detailView.addressTextField.text ?? ""
            
            detailView.member = member
            
            // 커스텀 델리게이트 패턴
            guard let member = member else { return }
            delegate?.updateMemberInfo(memberNumber, member)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 이미지뷰가 눌렸을 때의 동작 설정
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(touchUpImageView))
        detailView.memberImageView.addGestureRecognizer(tapGesture)
        detailView.memberImageView.isUserInteractionEnabled = true
    }
    
    @objc private func touchUpImageView() {
        var configuration = PHPickerConfiguration()
        // 유저가 선택할 수 있는 에셋의 최대 갯수. 0일 때는 시스템이 지원하는 최댓값으로 설정됨
        configuration.selectionLimit = 0
        // picker가 표시할 수 있는 에셋 타입 제한을 적용. 기본적으로 모든 에셋 유형을 표시(이미지, 라이브포토, 비디오)
        configuration.filter = .any(of: [.images, .videos])
        
        // 기본설정을 가지고, 피커뷰컨트롤러 생성
        let picker = PHPickerViewController(configuration: configuration)
        
        // 피커뷰컨트롤러의 대리자 설정
        picker.delegate = self
        
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
    
}

extension DetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                // itemProvider는 background asnyc작업이기 때문에 UI와 관련된 업데이트는 꼭 main쓰레드에서 실행해줘야 함
                DispatchQueue.main.sync {
                    self.detailView.memberImageView.image = image as? UIImage
                }
             }
        } else {
            print("이미지 로드 실패")
        }
    }
}

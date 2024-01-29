//
//  DetailView.swift
//  MemberList
//
//  Created by 예찬 on 1/19/24.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: - Property
    
    var member: Member? {
        didSet {
            guard var member = member else {
                // 멤버가 없으면 -> 새로운 멤버 추가하는 상황의 코드 구현
                saveButton.setTitle("Save", for: .normal)
                memberNumberTextField.text = "\(Member.memberNumbers)"
                return
            }
            // 멤버가 있으면 데이터 전달
            memberImageView.image = member.memberImage
            memberNumberTextField.text = "\(member.memberId)"
            nameTextField.text = member.name
            phoneNumberTextField.text = member.phoneNumber
            addressTextField.text = member.address
            
            guard let age = member.age else {
                ageTextField.text = ""
                return
            }
            ageTextField.text = "\(age)"
        }
    }
    // 여러개의 label의 width를 위한 프로퍼티
    let labelWidth: CGFloat = 70
    // 애니메이션을 위한 프로퍼티
    var stackViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - UIProperty
    
    let memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        return imageView
    }()
    
    lazy var imageContainView: UIView = {
        let view = UIView()
        view.addSubview(memberImageView)
        return view
    }()
    
    let memberNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "멤버번호:"
        return label
    }()
    
    let memberNumberTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 22
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        return textField
    }()
    
    lazy var memberNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [memberNumberLabel, memberNumberTextField])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "이       름:"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 22
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        return textField
    }()
    
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "나       이:"
        return label
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 22
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        return textField
    }()
    
    lazy var ageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ageLabel, ageTextField])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "전화번호:"
        return label
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 22
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        return textField
    }()
    
    lazy var phoneNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextField])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "주       소:"
        return label
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 22
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        return textField
    }()
    
    lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame.size.height = 40
        return button
    }()
    
    lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageContainView, memberNumberStackView,
                                                       nameStackView, ageStackView,
                                                       phoneNumberStackView, addressStackView, saveButton])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Method

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints()
        configureUI()
        configureMemberNumberTextField()
        configureNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func translatesAutoresizingMaskIntoConstraints() {
        memberImageView.translatesAutoresizingMaskIntoConstraints = false
        imageContainView.translatesAutoresizingMaskIntoConstraints = false
        memberNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        memberNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageStackView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressStackView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureUI() {
        self.addSubview(totalStackView)
    }

    // MARK: - AutoLayout Method
    
    override func updateConstraints() {
        configureConstraints()
        super.updateConstraints()
    }
    
    private func configureConstraints() {
        stackViewTopConstraint =
        totalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            imageContainView.heightAnchor.constraint(equalToConstant: 180),
            
            memberImageView.heightAnchor.constraint(equalToConstant: 150),
            memberImageView.widthAnchor.constraint(equalToConstant: 150),
            memberImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
            memberImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor),
            
            memberNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            ageLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            addressLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            
            stackViewTopConstraint,
            totalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            totalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    
    // MARK: - 키보드 관련 메서드
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveUpAction),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveDownAction),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func moveUpAction() {
        stackViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func moveDownAction() {
        stackViewTopConstraint.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // 키보드 밖 화면 터치시 키보드 내려가는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    // 실행된 후 노티피케이션 객체를 소멸시키기 위한 deinit
    deinit {
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
// MARK: - UITextFieldDelegate

// 멤버번호를 수정하지 못하도록 하기 위한 UITextFieldDelegate
extension DetailView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == memberNumberTextField {
            return false
        }
        return true
    }
    
    private func configureMemberNumberTextField() {
        memberNumberTextField.delegate = self
    }
}

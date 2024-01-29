//
//  ViewController.swift
//  MemberList
//
//  Created by 예찬 on 1/18/24.
//

import UIKit

final class ViewController: UIViewController {
    private let tableView = UITableView()
    private var memberListManager = MemberListManager()
    
    lazy var addMemberButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(addMemberButtonTapped))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        configureConstraints()
        configureData()
    }
    
    // 화면업데이트가 필요없어도 돌아올 때마다 reloadData == 비효율 -> 커스텀 델리게이트로 해결
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
    
    private func configureTableView() {
//        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    // 테이블뷰 오토레이아웃 설정
    private func configureConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    private func configureNavigationBar() {
        title = "멤버 목록"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션바 우측 상단 버튼 설정
        self.navigationItem.rightBarButtonItem = self.addMemberButton
    }
    
    private func configureData() {
        memberListManager.makeMembersListData()
    }
    
    @objc private func addMemberButtonTapped() {
        let detailViewController = DetailViewController()
        // 새로운 멤버를 추가할 때 필요한 대리자 설정
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - extension

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMemberList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MainTableViewCell
        cell.member = memberListManager[indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        
        // MemberDelegate의 대리자 설정
        // 업데이트할 때 사용될 대리자 설정
        detailViewController.delegate = self
        
        // 다음 화면으로 데이터 전달
        let memberInfo = memberListManager.getMemberList()
        detailViewController.member = memberInfo[indexPath.row]
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: MemberDelegate {
    func addNewMember(_ member: Member) {
        memberListManager.makeNewMember(member)
        tableView.reloadData()
    }
    
    func updateMemberInfo(_ index: Int, _ member: Member) {
        memberListManager.updateMemberInfo(index: index, member)
        tableView.reloadData()
    }
}

  

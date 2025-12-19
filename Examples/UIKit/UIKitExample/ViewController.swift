//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit
import ValidatorCore
import ValidatorUI

// MARK: - ViewController

final class ViewController: UIViewController {
    private let examples: [ExampleItem] = [
        ExampleItem(title: "UITextField Example", controller: LoginTextFieldExampleViewController()),
        ExampleItem(title: "UITextView Example", controller: FeedbackTextViewExampleViewController()),
    ]

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Examples"
        view.backgroundColor = .systemBackground

        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        examples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let example = examples[indexPath.row]
        cell.textLabel?.text = example.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let example = examples[indexPath.row]
        navigationController?.pushViewController(example.controller, animated: true)
    }
}

// MARK: - ExampleItem

struct ExampleItem {
    let title: String
    let controller: UIViewController
}

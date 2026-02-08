//
//  BluetoothMidiView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/02/07.
//

#if os(iOS)

  import CoreAudioKit
  import SwiftUI
  import UIKit

  struct BluetoothMIDIView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BTMIDICentralViewController {
      BTMIDICentralViewController()
    }

    func updateUIViewController(
      _ uiViewController: BTMIDICentralViewController,
      context: Context
    ) {}

    typealias UIViewControllerType = BTMIDICentralViewController
  }

  final class BTMIDICentralViewController: CABTMIDICentralViewController {
    var uiViewController: UIViewController?

    override public func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(doneAction)
      )
    }

    @objc
    public func doneAction() {
      uiViewController?.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
      -> UITableViewCell
    {
      let cell = super.tableView(tableView, cellForRowAt: indexPath)
      if !cell.isHidden {
        print("-----------------------")
        print(cell)
        print(cell.contentView)
        cell.contentView.backgroundColor = .brown
        for subview in cell.contentView.subviews {
          print(subview)
          if let label = subview as? UILabel {
            print(label.tag)
            print(label.text ?? "")
            label.font = UIFont.systemFont(ofSize: 20)
            //          label.textColor = .green
          }
        }
      }
      return cell
    }
  }

#endif

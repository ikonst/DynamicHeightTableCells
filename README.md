# Dynamic Height Table Cells — Sample Project

This sample project shows how to animate UITableView row height changes. The magic happens in `ViewController.cellHeightDidChange`.

## Usage

- The contents of the `UITableViewCell`s should have constraints tying them to the cell's top and bottom.
- Internally UITableView measures the intrinsic height of each cell, then assigns it a required (priority = 1000) height constraint. To avoid conflict warnings in UIB, avoid required (priority = 1000) static height constraints on the contents of table cells.
- When a cell has a good idea that its intrinsic height changed, it should call `heightChangedClosure`.
- 

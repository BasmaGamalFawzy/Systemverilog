# SystemVerilog Learning Repository

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-blue)
![Learning](https://img.shields.io/badge/Purpose-Learning-green)

A comprehensive collection of SystemVerilog examples organized by topics, covering everything from basic data types to advanced verification concepts. Perfect for beginners and intermediate learners looking to master SystemVerilog for design and verification.

## 📋 Table of Contents

- [About](#about)
- [Repository Structure](#repository-structure)
- [Topics Covered](#topics-covered)
- [Getting Started](#getting-started)
- [How to Use This Repository](#how-to-use-this-repository)
- [Prerequisites](#prerequisites)
- [Running Examples](#running-examples)
- [Learning Path](#learning-path)
- [Contributing](#contributing)
- [Resources](#resources)
- [Contact](#contact)

## 🎯 About

This repository contains hands-on SystemVerilog examples organized into progressive experiments (exp1, exp2, etc.) for each major topic. Each example is designed to demonstrate specific concepts with practical code that you can simulate and learn from.

**What makes this repository special:**
- ✅ Structured learning path from basics to advanced topics
- ✅ Practical, runnable examples for each concept
- ✅ Covers both RTL design and verification concepts
- ✅ Focus on modern SystemVerilog features
- ✅ Real-world patterns and best practices

## 📁 Repository Structure

```
Systemverilog/
├── 01-DataTypes/
│   ├── exp1  → bit, logic, event, byte (why no reg)
│   ├── exp2  → packed & unpacked structures
│   ├── exp3  → enum basics, methods (last, next, name)
│   ├── exp4  → enum state machine custom coding
│   ├── exp5  → arrays: packed & unpacked
│   ├── exp6  → array methods
│   ├── exp7  → dynamic arrays & methods
│   ├── exp8  → associative arrays
│   ├── exp9  → queues: basics, push/pop methods
│   ├── exp10 → string arrays, file I/O
│   └── exp11 → struct & union
│
├── 02-Procedural blocks/
│   ├── exp1 → initial, final, always, always_comb, always_latch, always_ff
│   ├── exp2 → fork/join basics
│   ├── exp3 → fork/join, join_any, join_none
│   ├── exp4 → blocking & non-blocking assignments
│   ├── exp5 → loops: for, while, repeat, forever, foreach
│   ├── exp6 → conditionals: if, case, casez, casex
│   └── exp7 → generate blocks
│
├── 03-Interfaces/
│   ├── exp1 → interface basics
│   ├── exp2 → interface modport
│   ├── exp3 → virtual interface inside class
│   ├── exp4 → clocking block
│   └── exp5 → interface using clocking block
│
├── 05-OOP/
│   ├── Inheritance & super keyword
│   ├── Polymorphism & virtual functions
│   ├── Virtual class & pure virtual functions
│   ├── Aggregated classes
│   ├── Shallow & deep copy
│   ├── Constructor & this keyword
│   ├── extern functions
│   ├── automatic & static methods
│   └── pass by value, reference, const reference
│
├── 06-Randomization/
│   ├── exp1 → basics: rand, randc
│   ├── exp2 → constraints basics
│   ├── exp3 → inside keyword
│   ├── exp4 → extern constraints
│   ├── exp5 → custom post_randomize() & pre_randomize()
│   ├── exp6 → dist operator
│   ├── exp7 → constraint operators: implication, equivalence, if/else
│   ├── exp8 → rand_mode(), constraint_mode() control
│   └── exp9 → randcase, local/this/super keywords
│
├── 07-IPC/
│   ├── exp1 → events: ->, ->>, @(), wait()
│   ├── exp2 → event ordering, merge events
│   ├── exp3 → semaphore: new(), put(), get()
│   ├── exp4 → mailbox basics: put(), get()
│   ├── exp5 → mailbox custom constructor, transaction data
│   └── exp6 → parameterized mailbox
│
├── 08-Coverage/
│   ├── exp1 → coverage group + options
│   ├── exp2 → conditional coverage
│   ├── exp3 → working with bins
│   ├── exp4 → bins filtering
│   ├── exp5 → reusable coverage groups
│   ├── exp6 → cross coverage
│   ├── exp7 → custom sample coverage group
│   └── exp8 → transition coverpoints
│
├── 09-Assertions/
│   └── (Coming soon - SVA concepts and examples)
│
├── Examples/
│   ├── FIFO
│   └── SPI
└── Revision/
    └── Interview Questions & Key Concepts Review
```

## 📚 Topics Covered

### 1. Data Types (11 experiments)
Learn SystemVerilog's rich type system including 2-state and 4-state types, structures, enums, and various array types.

### 2. Processes & Control Flow (7+ experiments)
Master different process types, parallel execution with fork/join, loops, and control flow statements.

### 3. Interfaces (5 experiments)
Understand interface-based design, modports, virtual interfaces, and clocking blocks for clean testbench architecture.

### 4. Object-Oriented Programming
Deep dive into OOP concepts including inheritance, polymorphism, copy mechanisms, and method types.

### 5. Constrained Randomization (9 experiments)
Learn to generate constrained random stimulus for verification using rand variables, constraints, and distributions.

### 6. Inter-Process Communication (6 experiments)
Master synchronization mechanisms including events, semaphores, and mailboxes for testbench communication.

### 7. Functional Coverage (8 experiments)
Learn to measure verification completeness using covergroups, bins, cross coverage, and transition coverage.

### 8. Assertions
SystemVerilog Assertions (SVA) for property-based verification (coming soon).

### 9. Revision & Interview Prep
Curated interview questions and key concepts review for SystemVerilog verification roles.

## 🚀 Getting Started

### Prerequisites

You'll need a SystemVerilog-compatible simulator. Recommended options:

- **Free/Open Source:**
  - [EDA Playground](https://www.edaplayground.com/) (online, no installation)
  - [Icarus Verilog](http://iverilog.icarus.com/) (limited SV support)

- **Commercial (free editions available):**
  - [ModelSim Intel FPGA Edition](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/model-sim.html)
  - [Xilinx Vivado](https://www.xilinx.com/products/design-tools/vivado.html)
  - [Synopsys VCS](https://www.synopsys.com/verification/simulation/vcs.html)

### Installation

```bash
# Clone the repository
git clone https://github.com/BasmaGamalFawzy/Systemverilog.git
cd Systemverilog

# Navigate to any topic
cd 01-DataTypes/exp1
```

## 💻 How to Use This Repository

### Recommended Learning Path

1. **Start with Data Types** (01-DataTypes)
   - Begin with exp1 and progress sequentially
   - Each example builds on previous concepts

2. **Move to Processes** (02-Processes)
   - Understand how SystemVerilog executes code
   - Learn parallel execution and timing control

3. **Learn Interfaces** (03-Interfaces)
   - Essential for modern testbench design
   - Understand modports and clocking blocks

4. **Master OOP Concepts** (04-OOP)
   - Critical for verification methodology
   - Practice inheritance and polymorphism

5. **Constrained Randomization** (05-Randomization)
   - Core verification technique
   - Learn to generate directed-random tests

6. **Inter-Process Communication** (06-IPC)
   - Synchronize multiple testbench components
   - Use mailboxes for data passing

7. **Functional Coverage** (07-Coverage)
   - Measure verification completeness
   - Learn covergroups, bins, and cross coverage
   - Track what scenarios have been tested

8. **Assertions** (08-Assertions)
   - Property-based verification (coming soon)
   - Learn SVA for checking design properties

9. **Interview Preparation** (09-Revision)
   - Review key concepts
   - Practice common interview questions

### Running an Example

#### Using EDA Playground (Easiest)
1. Go to [edaplayground.com](https://www.edaplayground.com/)
2. Copy the code from any experiment
3. Select a simulator (e.g., Synopsys VCS)
4. Click "Run"

#### Using ModelSim
```bash
# Compile
vlog example.sv

# Simulate
vsim -c work.testbench -do "run -all; quit"
```

#### Using Vivado Simulator
```bash
# Compile
xvlog example.sv

# Elaborate
xelab testbench -debug typical

# Run
xsim testbench -R
```

## 🎓 Example Code Preview

### Data Types - Using logic vs bit
```systemverilog
module data_types_demo;
  bit    a;    // 2-state (0, 1)
  logic  b;    // 4-state (0, 1, X, Z)
  byte   c;    // 8-bit signed
  
  initial begin
    a = 1'bx;  // Becomes 0
    b = 1'bx;  // Stays X
    $display("bit a=%0b, logic b=%0b", a, b);
  end
endmodule
```

### Randomization - Basic Constraints
```systemverilog
class packet;
  rand bit [7:0] addr;
  rand bit [7:0] data;
  
  constraint addr_range { addr inside {[0:63]}; }
  constraint data_value { data > 10 && data < 200; }
endclass
```

### Interface - Modport Example
```systemverilog
interface bus_if;
  logic [7:0] data;
  logic valid;
  
  modport master (output data, valid);
  modport slave  (input data, valid);
endinterface
```

### Coverage - Covergroup Example
```systemverilog
class packet;
  rand bit [3:0] addr;
  rand bit [7:0] data;
  
  covergroup cg;
    addr_cp: coverpoint addr {
      bins low    = {[0:7]};
      bins high   = {[8:15]};
    }
    data_cp: coverpoint data;
    cross addr_cp, data_cp;
  endgroup
  
  function new();
    cg = new();
  endfunction
endclass
```

## 📖 Key Learning Concepts

### Why These Topics Matter

- **Data Types**: Foundation for everything - choosing the right type prevents bugs
- **Processes**: Understanding simulation semantics is crucial for correct designs
- **Interfaces**: Industry-standard way to connect modules and build testbenches
- **OOP**: Enables reusable, scalable verification environments (UVM foundation)
- **Randomization**: Generate thousands of test cases automatically
- **IPC**: Coordinate multiple verification components efficiently
- **Coverage**: Measure what you've tested and identify gaps
- **Assertions**: Catch bugs earlier with property checking

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Add more examples
- Improve existing code
- Fix bugs or add comments
- Suggest new topics

**How to contribute:**
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-example`)
3. Commit your changes (`git commit -m 'Add new example for X'`)
4. Push to the branch (`git push origin feature/new-example`)
5. Open a Pull Request

## 📚 Additional Resources

### Documentation
- [IEEE 1800-2017 SystemVerilog Standard](https://ieeexplore.ieee.org/document/8299595)
- [SystemVerilog ChipVerify Tutorial](https://www.chipverify.com/systemverilog/systemverilog-tutorial)
- [Verification Guide](https://verificationguide.com/systemverilog/)

### Books
- "SystemVerilog for Verification" by Chris Spear
- "Writing Testbenches using SystemVerilog" by Janick Bergeron
- "SystemVerilog for Design" by Stuart Sutherland

### Online Practice
- [EDA Playground](https://www.edaplayground.com/)
- [ASIC World SystemVerilog](http://www.asic-world.com/systemverilog/)

## 📝 Notes

- Each experiment includes detailed comments explaining the concepts
- Examples are designed to be self-contained and runnable
- Focus is on practical, working code rather than theoretical concepts
- Code follows industry coding standards and best practices

## 👤 Contact

**Basma Gamal Fawzy**

GitHub: [@BasmaGamalFawzy](https://github.com/BasmaGamalFawzy)

Project Link: [https://github.com/BasmaGamalFawzy/Systemverilog](https://github.com/BasmaGamalFawzy/Systemverilog)

## ⭐ Show Your Support

If you find this repository helpful, please give it a star! It helps others discover these learning resources.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy Learning! 🚀**

*This repository is actively maintained and updated with new examples regularly.*

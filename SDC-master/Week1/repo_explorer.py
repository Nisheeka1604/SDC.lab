#!/usr/bin/env python3
"""
Script to explore and understand the PyVNT repository structure
Run this to discover classes, methods, and functionality
"""

import os
import subprocess
import sys
from pathlib import Path

def clone_and_explore_repo():
    """Clone the repository and explore its structure"""
    repo_url = "https://github.com/FOSSEE/pyvnt.git"
    branch = "YashSuthar_sem_intern_2025"
    repo_dir = "pyvnt_repo"
    
    print("=== STEP 1: Cloning Repository ===")
    try:
        # Clone the specific branch
        subprocess.run([
            "git", "clone", "-b", branch, repo_url, repo_dir
        ], check=True)
        print(f"✅ Successfully cloned {branch} branch")
    except subprocess.CalledProcessError:
        print("❌ Failed to clone repository")
        return None
    
    return Path(repo_dir)

def explore_directory_structure(repo_path):
    """Explore and display directory structure"""
    print("\n=== STEP 2: Directory Structure ===")
    
    for root, dirs, files in os.walk(repo_path):
        level = root.replace(str(repo_path), '').count(os.sep)
        indent = ' ' * 2 * level
        print(f"{indent}{os.path.basename(root)}/")
        
        # Only show first 3 levels to avoid clutter
        if level < 3:
            subindent = ' ' * 2 * (level + 1)
            for file in files:
                if file.endswith(('.py', '.md', '.txt', '.yml', '.yaml', '.json')):
                    print(f"{subindent}{file}")

def analyze_python_files(repo_path):
    """Analyze Python files to find classes and methods"""
    print("\n=== STEP 3: Python Code Analysis ===")
    
    pyvnt_dir = repo_path / "pyvnt"
    if not pyvnt_dir.exists():
        print("❌ pyvnt directory not found")
        return
    
    python_files = list(pyvnt_dir.rglob("*.py"))
    
    for py_file in python_files:
        if py_file.name == "__init__.py":
            continue
            
        print(f"\n📄 File: {py_file.relative_to(repo_path)}")
        try:
            with open(py_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Find classes
            classes = []
            methods = []
            
            for line_num, line in enumerate(content.split('\n'), 1):
                line = line.strip()
                if line.startswith('class '):
                    class_name = line.split('class ')[1].split('(')[0].split(':')[0].strip()
                    classes.append((class_name, line_num))
                elif line.startswith('def ') and not line.startswith('def __'):
                    method_name = line.split('def ')[1].split('(')[0].strip()
                    methods.append((method_name, line_num))
            
            if classes:
                print("  🏗️  Classes:")
                for class_name, line_num in classes:
                    print(f"    - {class_name} (line {line_num})")
            
            if methods:
                print("  ⚙️  Methods:")
                for method_name, line_num in methods[:5]:  # Show first 5 methods
                    print(f"    - {method_name}() (line {line_num})")
                if len(methods) > 5:
                    print(f"    ... and {len(methods) - 5} more methods")
                    
        except Exception as e:
            print(f"    ❌ Error reading file: {e}")

def check_requirements(repo_path):
    """Check requirements and setup files"""
    print("\n=== STEP 4: Requirements & Setup ===")
    
    setup_files = ['requirements.txt', 'setup.py', 'pyproject.toml', 'environment.yml']
    
    for setup_file in setup_files:
        file_path = repo_path / setup_file
        if file_path.exists():
            print(f"📋 Found: {setup_file}")
            try:
                with open(file_path, 'r') as f:
                    content = f.read()[:500]  # First 500 chars
                    print(f"   Content preview:\n{content}")
                    if len(content) == 500:
                        print("   ...")
            except Exception as e:
                print(f"   ❌ Error reading {setup_file}: {e}")

def generate_sample_usage():
    """Generate sample usage code based on discovered structure"""
    print("\n=== STEP 5: Sample Usage Template ===")
    
    sample_code = '''
# Sample PyVNT + PyQt Integration Template
import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget
from PyQt5.QtCore import QTimer

# Import PyVNT modules (adjust based on actual structure)
try:
    from pyvnt import Node, NodeTree, Connection  # Hypothetical imports
    print("✅ PyVNT modules imported successfully")
except ImportError as e:
    print(f"❌ Failed to import PyVNT: {e}")
    print("   Check the actual module structure in the repository")

class OpenFOAMNode:
    """Base class for OpenFOAM-specific nodes"""
    def __init__(self, name, node_type):
        self.name = name
        self.node_type = node_type
        self.parameters = {}
        self.connections = []
    
    def set_parameter(self, key, value):
        self.parameters[key] = value
    
    def connect_to(self, other_node):
        self.connections.append(other_node)

class BoundaryConditionNode(OpenFOAMNode):
    """Node for boundary conditions"""
    def __init__(self, name, bc_type):
        super().__init__(name, "boundary_condition")
        self.bc_type = bc_type  # inlet, outlet, wall, etc.

class FieldNode(OpenFOAMNode):
    """Node for field variables"""
    def __init__(self, name, field_type):
        super().__init__(name, "field")
        self.field_type = field_type  # velocity, pressure, temperature

class NodeEditorWindow(QMainWindow):
    """Main PyQt window for node editing"""
    def __init__(self):
        super().__init__()
        self.setWindowTitle("OpenFOAM Case Builder")
        self.setGeometry(100, 100, 1000, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        layout = QVBoxLayout(central_widget)
        
        # Node storage
        self.nodes = []
        self.setup_ui()
    
    def setup_ui(self):
        """Setup the user interface"""
        # This would contain the actual node editor graphics
        pass
    
    def create_sample_case(self):
        """Create a sample OpenFOAM case using nodes"""
        # Create nodes
        inlet = BoundaryConditionNode("inlet", "inlet")
        outlet = BoundaryConditionNode("outlet", "outlet")
        walls = BoundaryConditionNode("walls", "wall")
        
        velocity_field = FieldNode("U", "velocity")
        pressure_field = FieldNode("p", "pressure")
        
        # Set parameters
        inlet.set_parameter("velocity", [1, 0, 0])
        inlet.set_parameter("type", "fixedValue")
        
        outlet.set_parameter("pressure", 0)
        outlet.set_parameter("type", "fixedValue")
        
        # Connect nodes (conceptually)
        inlet.connect_to(velocity_field)
        outlet.connect_to(pressure_field)
        
        self.nodes = [inlet, outlet, walls, velocity_field, pressure_field]
        print("✅ Sample case created with nodes:")
        for node in self.nodes:
            print(f"   - {node.name} ({node.node_type})")

def main():
    """Main execution function"""
    print("🚀 PyVNT + PyQt Integration Test")
    
    # Test PyQt
    app = QApplication(sys.argv)
    window = NodeEditorWindow()
    
    # Create sample case
    window.create_sample_case()
    
    # Show window
    window.show()
    
    # Auto-close after 3 seconds for demo
    QTimer.singleShot(3000, app.quit)
    
    print("🎯 Running PyQt application (will close in 3 seconds)")
    sys.exit(app.exec_())

if __name__ == "__main__":
    # First explore the repository
    repo_path = clone_and_explore_repo()
    if repo_path:
        explore_directory_structure(repo_path)
        analyze_python_files(repo_path)
        check_requirements(repo_path)
    
    generate_sample_usage()
    
    # Uncomment to run the PyQt demo
    # main()
'''
    
    print(sample_code)

def main():
    """Main function to run the repository exploration"""
    print("🔍 PyVNT Repository Explorer")
    print("=" * 50)
    
    repo_path = clone_and_explore_repo()
    if repo_path:
        explore_directory_structure(repo_path)
        analyze_python_files(repo_path)
        check_requirements(repo_path)
        generate_sample_usage()
    else:
        print("❌ Could not explore repository")
        print("\n💡 Alternative approach:")
        print("1. Manually clone: git clone -b YashSuthar_sem_intern_2025 https://github.com/FOSSEE/pyvnt.git")
        print("2. Explore the pyvnt/ directory")
        print("3. Look for main classes in Python files")
        print("4. Check __init__.py for exported modules")

if __name__ == "__main__":
    main()
#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "typer",
#     "rich",
#     "platformdirs",
#     "readchar",
#     "httpx",
#     "truststore",
# ]
# ///
"""
Agent Library - Dynamic Persona-Shifting Framework for AI Agents

Usage:
    agent-lib init <project-name>
    agent-lib init .
    agent-lib init --here
    agent-lib task "<description>" --context <context>
    agent-lib check
    agent-lib list personas
    agent-lib list tasks

Or install globally:
    uv tool install --from agent-lib agent-lib
    agent-lib init <project-name>
    agent-lib task "description" --context context
"""

import json
import os
import shutil
import ssl
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

import httpx
import truststore
import typer
from rich.align import Align
from rich.console import Console
from rich.live import Live
from rich.panel import Panel
from rich.table import Table
from rich.text import Text
from rich.tree import Tree
from typer.core import TyperGroup

ssl_context = truststore.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
client = httpx.Client(verify=ssl_context)

# Persona configuration
PERSONAS = {
    "architect": {
        "name": "Architect",
        "expertise": [
            "system design",
            "architecture",
            "high-level planning",
            "optimization",
        ],
        "primary_tasks": ["architecture", "planning", "optimization"],
        "keywords": [
            "design",
            "architecture",
            "structure",
            "plan",
            "diagram",
            "pattern",
            "scalability",
            "modularity",
        ],
    },
    "implementer": {
        "name": "Implementer",
        "expertise": ["coding", "feature development", "refactoring", "implementation"],
        "primary_tasks": ["implementation", "coding", "feature development"],
        "keywords": ["code", "implement", "build", "feature", "develop", "refactor", "write"],
    },
    "debugger": {
        "name": "Debugger",
        "expertise": ["troubleshooting", "issue diagnosis", "root cause analysis"],
        "primary_tasks": ["debugging", "issue resolution"],
        "keywords": ["debug", "bug", "fix", "issue", "error", "crash", "broken", "problem"],
    },
    "reviewer": {
        "name": "Reviewer",
        "expertise": ["code review", "quality assurance", "standards enforcement"],
        "primary_tasks": ["code_review", "quality assurance"],
        "keywords": ["review", "quality", "check", "approve", "validate", "test", "verify"],
    },
    "researcher": {
        "name": "Researcher",
        "expertise": ["investigation", "knowledge gathering", "technology evaluation"],
        "primary_tasks": ["research", "investigation"],
        "keywords": [
            "research",
            "investigate",
            "evaluate",
            "compare",
            "explore",
            "analyze",
            "study",
        ],
    },
    "documentarian": {
        "name": "Documentarian",
        "expertise": ["technical writing", "documentation", "clarity"],
        "primary_tasks": ["documentation", "technical writing"],
        "keywords": ["document", "write", "guide", "readme", "tutorial", "example", "explain"],
    },
    "optimizer": {
        "name": "Optimizer",
        "expertise": ["performance optimization", "efficiency", "resource management"],
        "primary_tasks": ["optimization", "performance tuning"],
        "keywords": ["optimize", "performance", "speed", "efficiency", "scale", "benchmark"],
    },
    "tester": {
        "name": "Tester",
        "expertise": ["testing", "quality assurance", "validation"],
        "primary_tasks": ["testing", "quality assurance"],
        "keywords": ["test", "testing", "coverage", "validate", "suite", "assert", "spec"],
    },
}

# Agent configuration
AGENT_CONFIG = {
    "amp": {
        "name": "Amp",
        "folder": ".agents/",
        "install_url": "https://ampcode.com/",
        "requires_cli": True,
    },
    "auggie": {
        "name": "Auggie",
        "folder": ".auggie/",
        "install_url": None,
        "requires_cli": False,
    },
    "bob": {
        "name": "Bob",
        "folder": ".bob/",
        "install_url": None,
        "requires_cli": False,
    },
    "claude": {
        "name": "Claude Code",
        "folder": ".agents/",
        "install_url": "https://docs.anthropic.com/en/docs/claude-code/setup",
        "requires_cli": True,
    },
    "codebuddy": {
        "name": "CodeBuddy",
        "folder": ".codebuddy/",
        "install_url": None,
        "requires_cli": False,
    },
    "codex": {
        "name": "Codex",
        "folder": ".codex/",
        "install_url": None,
        "requires_cli": False,
    },
    "copilot": {
        "name": "GitHub Copilot",
        "folder": ".github/",
        "install_url": None,
        "requires_cli": False,
    },
    "cursor-agent": {
        "name": "Cursor",
        "folder": ".cursor/",
        "install_url": None,
        "requires_cli": False,
    },
    "gemini": {
        "name": "Gemini CLI",
        "folder": ".gemini/",
        "install_url": "https://github.com/google-gemini/gemini-cli",
        "requires_cli": True,
    },
    "kilocode": {
        "name": "KiloCode",
        "folder": ".kilocode/",
        "install_url": None,
        "requires_cli": False,
    },
    "opencode": {
        "name": "OpenCode",
        "folder": ".opencode/",
        "install_url": None,
        "requires_cli": False,
    },
    "q": {
        "name": "Q",
        "folder": ".q/",
        "install_url": None,
        "requires_cli": False,
    },
    "qwen": {
        "name": "Qwen",
        "folder": ".qwen/",
        "install_url": None,
        "requires_cli": False,
    },
    "roo": {
        "name": "Roo",
        "folder": ".roo/",
        "install_url": None,
        "requires_cli": False,
    },
    "shai": {
        "name": "Shai",
        "folder": ".shai/",
        "install_url": None,
        "requires_cli": False,
    },
    "windsurf": {
        "name": "Windsurf",
        "folder": ".windsurf/",
        "install_url": None,
        "requires_cli": False,
    },
}

BANNER = """
    ░███      ░██████  ░██████████ ░███    ░██ ░██████████
   ░██░██    ░██   ░██ ░██         ░████   ░██     ░██
  ░██  ░██  ░██        ░██         ░██░██  ░██     ░██
 ░█████████ ░██  █████ ░█████████  ░██ ░██ ░██     ░██
 ░██    ░██ ░██     ██ ░██         ░██  ░██░██     ░██
 ░██    ░██  ░██  ░███ ░██         ░██   ░████     ░██
 ░██    ░██   ░█████░█ ░██████████ ░██    ░███     ░██
"""

TAGLINE = "Agent Library - Dynamic Persona-Shifting Framework"

console = Console()


class StepTracker:
    """Track and render hierarchical steps."""

    def __init__(self, title: str):
        self.title = title
        self.steps = []
        self.status_order = {"pending": 0, "running": 1, "done": 2, "error": 3, "skipped": 4}
        self._refresh_cb = None

    def attach_refresh(self, cb):
        self._refresh_cb = cb

    def add(self, key: str, label: str):
        if key not in [s["key"] for s in self.steps]:
            self.steps.append({"key": key, "label": label, "status": "pending", "detail": ""})
            self._maybe_refresh()

    def start(self, key: str, detail: str = ""):
        self._update(key, status="running", detail=detail)

    def complete(self, key: str, detail: str = ""):
        self._update(key, status="done", detail=detail)

    def error(self, key: str, detail: str = ""):
        self._update(key, status="error", detail=detail)

    def skip(self, key: str, detail: str = ""):
        self._update(key, status="skipped", detail=detail)

    def _update(self, key: str, status: str, detail: str):
        for s in self.steps:
            if s["key"] == key:
                s["status"] = status
                if detail:
                    s["detail"] = detail
                self._maybe_refresh()
                return
        self.steps.append({"key": key, "label": key, "status": status, "detail": detail})
        self._maybe_refresh()

    def _maybe_refresh(self):
        if self._refresh_cb:
            try:
                self._refresh_cb()
            except Exception:
                pass

    def render(self):
        tree = Tree(f"[cyan]{self.title}[/cyan]", guide_style="grey50")
        for step in self.steps:
            label = step["label"]
            detail_text = step["detail"].strip() if step["detail"] else ""
            status = step["status"]

            if status == "done":
                symbol = "[green]●[/green]"
            elif status == "pending":
                symbol = "[green dim]○[/green dim]"
            elif status == "running":
                symbol = "[cyan]○[/cyan]"
            elif status == "error":
                symbol = "[red]●[/red]"
            elif status == "skipped":
                symbol = "[yellow]○[/yellow]"
            else:
                symbol = " "

            if detail_text:
                line = (
                    f"{symbol} [white]{label}[/white] "
                    f"[bright_black]({detail_text})[/bright_black]"
                )
            else:
                line = f"{symbol} [white]{label}[/white]"

            tree.add(line)
        return tree


class BannerGroup(TyperGroup):
    """Custom group that shows banner before help."""

    def format_help(self, ctx, formatter):
        show_banner()
        super().format_help(ctx, formatter)


app = typer.Typer(
    name="agent-lib",
    help="Dynamic persona-shifting framework for AI agents",
    add_completion=False,
    invoke_without_command=True,
    cls=BannerGroup,
)


def show_banner():
    """Display the ASCII art banner."""
    banner_lines = BANNER.strip().split("\n")
    colors = ["bright_blue", "blue", "cyan", "bright_cyan", "white"]

    styled_banner = Text()
    for i, line in enumerate(banner_lines):
        color = colors[i % len(colors)]
        styled_banner.append(line + "\n", style=color)

    console.print(Align.center(styled_banner))
    console.print(Align.center(Text(TAGLINE, style="italic bright_yellow")))
    console.print()


@app.callback()
def callback(ctx: typer.Context):
    """Show banner when no subcommand is provided."""
    if ctx.invoked_subcommand is None and "--help" not in sys.argv and "-h" not in sys.argv:
        show_banner()
        console.print(Align.center("[dim]Run 'agent-lib --help' for usage information[/dim]"))
        console.print()


class ContextTracker:
    """Manages project state, decisions, and task history."""

    def __init__(self, context_dir: Path = None):
        """
        Initialize context tracker.

        Args:
            context_dir: Path to .agents/context/ directory
        """
        if context_dir is None:
            context_dir = Path(".agents/context")
        self.context_dir = context_dir
        self.state_file = context_dir / "state.json"
        self.memory_file = context_dir / "memory.md"

    def load_state(self) -> dict:
        """Load project state from JSON."""
        if self.state_file.exists():
            return json.loads(self.state_file.read_text())
        return {
            "project": {"created": datetime.now(timezone.utc).isoformat()},
            "phase": "initialization",
            "active_personas": [],
            "completed_tasks": [],
            "decisions": [],
        }

    def save_state(self, state: dict) -> None:
        """Save project state to JSON."""
        self.context_dir.mkdir(parents=True, exist_ok=True)
        self.state_file.write_text(json.dumps(state, indent=2))

    def record_task(self, description: str, personas: list[str], context: str = None) -> None:
        """Record a task execution in context."""
        state = self.load_state()

        task_entry = {
            "description": description,
            "personas": personas,
            "context": context,
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }

        if "completed_tasks" not in state:
            state["completed_tasks"] = []
        state["completed_tasks"].append(task_entry)

        state["active_personas"] = personas

        self.save_state(state)

    def record_decision(self, title: str, decision: str, reasoning: str = None) -> None:
        """Record a project decision."""
        state = self.load_state()

        decision_entry = {
            "title": title,
            "decision": decision,
            "reasoning": reasoning,
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }

        if "decisions" not in state:
            state["decisions"] = []
        state["decisions"].append(decision_entry)

        self.save_state(state)

    def get_task_history(self, limit: int = 10) -> list[dict]:
        """Get recent task history."""
        state = self.load_state()
        tasks = state.get("completed_tasks", [])
        return tasks[-limit:]

    def get_decisions(self) -> list[dict]:
        """Get all recorded decisions."""
        state = self.load_state()
        return state.get("decisions", [])


class PersonaSelector:
    """Analyzes task descriptions and selects appropriate personas."""

    @staticmethod
    def select_personas(task_description: str, task_context: Optional[str] = None) -> list[str]:
        """
        Select personas based on task description and context.

        Args:
            task_description: Description of the task to perform
            task_context: Optional context (backend, frontend, testing, etc.)

        Returns:
            List of persona keys to activate
        """
        task_text = (task_description + " " + (task_context or "")).lower()

        # Score each persona based on keyword matches
        persona_scores = {}
        for persona_key, persona_info in PERSONAS.items():
            score = 0
            for keyword in persona_info.get("keywords", []):
                if keyword.lower() in task_text:
                    score += 2
            # Bonus for matching primary tasks
            for task in persona_info.get("primary_tasks", []):
                if task.lower() in task_text:
                    score += 3
            if score > 0:
                persona_scores[persona_key] = score

        # If no keywords matched, use heuristics
        if not persona_scores:
            if any(word in task_text for word in ["build", "create", "add", "make"]):
                persona_scores["implementer"] = 5
            if any(word in task_text for word in ["fix", "broken", "error", "issue"]):
                persona_scores["debugger"] = 5
            if any(word in task_text for word in ["test", "verify", "validate"]):
                persona_scores["tester"] = 5
            else:
                # Default to implementer
                persona_scores["implementer"] = 1

        # Sort by score, return top personas (typically 1-3)
        sorted_personas = sorted(persona_scores.items(), key=lambda x: x[1], reverse=True)
        selected = [p[0] for p in sorted_personas[:3]]  # Up to 3 personas

        # Always include reviewer for code-related tasks (except pure research/documentation)
        if any(p in selected for p in ["implementer", "debugger", "optimizer"]):
            if "reviewer" not in selected:
                selected.append("reviewer")

        return selected[:3]  # Cap at 3 personas


def check_tool(tool: str, tracker: StepTracker = None) -> bool:
    """Check if a tool is installed."""
    found = shutil.which(tool) is not None
    if tracker:
        if found:
            tracker.complete(tool, "available")
        else:
            tracker.error(tool, "not found")
    return found


@app.command()
def init(
    project_name: str = typer.Argument(None, help="Name for your new project directory"),
    ai: str = typer.Option(
        None,
        "--ai",
        help="AI assistant: amp, auggie, bob, claude, codebuddy, codex, copilot, cursor-agent, gemini, kilocode, opencode, q, qwen, roo, shai, windsurf",
    ),
    here: bool = typer.Option(False, "--here", help="Initialize in current directory"),
):
    """Initialize a new Agent Library project."""
    show_banner()

    if here:
        project_path = Path.cwd()
        project_name = project_path.name
    else:
        if not project_name:
            console.print("[red]Error:[/red] Specify project name or use --here")
            raise typer.Exit(1)
        project_path = Path(project_name)
        if project_path.exists():
            console.print(f"[red]Error:[/red] Directory '{project_name}' already exists")
            raise typer.Exit(1)
        project_path.mkdir(parents=True)

    console.print(
        Panel(
            f"[cyan]Initializing Agent Library Project[/cyan]\n"
            f"Project: [green]{project_path.name}[/green]",
            border_style="cyan",
            padding=(1, 2),
        )
    )

    # Create project structure
    tracker = StepTracker("Initialize Project")

    tracker.add("dirs", "Create project directories")
    (project_path / ".agents").mkdir(exist_ok=True)
    (project_path / ".agents" / "personas").mkdir(exist_ok=True)
    (project_path / ".agents" / "tasks").mkdir(exist_ok=True)
    (project_path / ".agents" / "context").mkdir(exist_ok=True)
    (project_path / "src").mkdir(exist_ok=True)
    (project_path / "tests").mkdir(exist_ok=True)
    (project_path / "docs").mkdir(exist_ok=True)
    tracker.complete("dirs")

    # AI Agent selection
    if not ai:
        console.print("\nWhich AI agent are you using?")
        for i, (key, config) in enumerate(AGENT_CONFIG.items(), 1):
            console.print(f"  [cyan]{i}[/cyan] {config['name']}")

        choice = input("\nSelect (1-5): ").strip()
        ai_map = {str(i): key for i, key in enumerate(AGENT_CONFIG.keys(), 1)}
        ai = ai_map.get(choice, "claude")

    tracker.add("config", f"Create configuration for {ai}")
    config_content = f"""# Agent Library Project Configuration

project:
  name: {project_path.name}
  ai_agent: {ai}
  version: 0.1.0

# Personas available in this project
personas:
  - architect
  - implementer
  - debugger
  - reviewer
  - researcher
  - documentarian
  - optimizer
  - tester

# Task types for this project
task_types:
  - planning
  - architecture
  - implementation
  - debugging
  - code_review
  - research
  - documentation
  - optimization
  - testing
"""
    (project_path / ".agents" / "config.yml").write_text(config_content)
    tracker.complete("config")

    # Copy task templates to project
    tracker.add("tasks", "Copy task templates")
    template_dir = Path(__file__).parent.parent.parent / "templates" / "tasks"
    if template_dir.exists():
        tasks_dir = project_path / ".agents" / "tasks"
        tasks_dir.mkdir(exist_ok=True)
        for task_file in template_dir.glob("*.md"):
            target = tasks_dir / task_file.name
            target.write_text(task_file.read_text())
        tracker.complete("tasks", f"{len(list(template_dir.glob('*.md')))} templates")
    else:
        tracker.skip("tasks", "template directory not found")

    # Initialize project context using script
    tracker.add("context", "Initialize project context")
    try:
        script_dir = Path(__file__).parent.parent.parent / "scripts" / "bash"
        script_path = script_dir / "create-project-context.sh"
        if script_path.exists() and os.name != "nt":
            subprocess.run(
                ["bash", str(script_path), str(project_path), project_name],
                check=True,
            )
        # Windows or script not found - create context directly
        (project_path / ".agents" / "context").mkdir(exist_ok=True)
        (project_path / ".agents" / "memory").mkdir(exist_ok=True)
        context_state = json.dumps(
            {
                "project": {"name": project_name, "created": datetime.now().isoformat()},
                "phase": "initialization",
                "active_personas": [],
                "completed_tasks": [],
            },
            indent=2,
        )
        (project_path / ".agents" / "context" / "state.json").write_text(context_state)
        tracker.complete("context")
    except Exception as e:
        console.print(f"[yellow]Warning:[/yellow] Context initialization had issues: {e}")
        tracker.skip("context", "Manual setup needed")

    with Live(tracker.render(), console=console, transient=True) as live:
        tracker.attach_refresh(lambda: live.update(tracker.render()))

    console.print(tracker.render())

    console.print(
        Panel(
            f"[green]✓ Project initialized successfully![/green]\n\n"
            f"[bold]Next steps:[/bold]\n"
            f"1. cd {project_name}\n"
            f"2. Review task templates in .agents/tasks/\n"
            f"3. Use your AI agent to execute tasks\n"
            f'4. agent-lib task "<description>" to see persona selection',
            border_style="green",
            padding=(1, 2),
        )
    )


@app.command()
def check():
    """Check for installed AI agents and tools."""
    show_banner()
    console.print("[bold]Checking for installed tools...[/bold]\n")

    tracker = StepTracker("Check Available Tools")
    tracker.add("git", "Git version control")
    check_tool("git", tracker=tracker)

    for agent_key, agent_config in AGENT_CONFIG.items():
        tracker.add(agent_key, agent_config["name"])
        if agent_config["requires_cli"]:
            check_tool(agent_key, tracker=tracker)
        else:
            tracker.skip(agent_key, "IDE-based, no CLI check")

    console.print(tracker.render())
    console.print("\n[bold green]Check complete![/bold green]")


@app.command()
def task(
    description: str = typer.Argument(..., help="Task description"),
):
    """Execute a task with automatic persona selection."""
    console.print(
        Panel(
            f"[bold]Task:[/bold] {description}",
            title="Execute Task",
            border_style="blue",
        )
    )

    # Select personas based on task description
    selected_persona_keys = PersonaSelector.select_personas(description)

    console.print("\n[bold]Persona Selection:[/bold]")
    selected_personas = [PERSONAS[key] for key in selected_persona_keys]
    persona_names = ", ".join([p["name"] for p in selected_personas])
    console.print(f"  [cyan]→[/cyan] {persona_names}")

    console.print("\n[yellow]Note:[/yellow] Task execution with agent integration coming soon.")


@app.command()
def list(
    item_type: str = typer.Argument("personas", help="What to list: personas or tasks"),
):
    """List available personas or task types."""
    if item_type == "personas":
        console.print("[bold]Available Personas:[/bold]\n")

        table = Table(title="Personas")
        table.add_column("Persona", style="cyan")
        table.add_column("Expertise", style="green")
        table.add_column("Primary Tasks", style="yellow")

        for key, persona in PERSONAS.items():
            table.add_row(
                persona["name"],
                ", ".join(persona["expertise"][:2]),
                ", ".join(persona["primary_tasks"][:2]),
            )

        console.print(table)
    elif item_type == "tasks":
        console.print("[bold]Available Task Types:[/bold]\n")

        task_types = [
            "planning",
            "architecture",
            "implementation",
            "debugging",
            "code_review",
            "research",
            "documentation",
            "optimization",
            "testing",
        ]

        for task_type in task_types:
            console.print(f"  • {task_type}")
    else:
        console.print(f"[red]Unknown type: {item_type}. Use 'personas' or 'tasks'[/red]")


def main():
    app()


# Public API - export for use by agents and scripts
__all__ = [
    "PersonaSelector",
    "ContextTracker",
    "PERSONAS",
    "AGENT_CONFIG",
]


if __name__ == "__main__":
    main()

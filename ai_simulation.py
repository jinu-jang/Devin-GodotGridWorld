import random
import heapq

# Constants
GRID_SIZE = 10
WALL_TILE = -1
FLOOR_TILE = 0

# Initialize a 10x10 grid world with floor tiles
grid_world = [[FLOOR_TILE for _ in range(GRID_SIZE)] for _ in range(GRID_SIZE)]

# Function to add walls to the grid world
def add_walls(wall_positions):
    for pos in wall_positions:
        x, y = pos
        grid_world[y][x] = WALL_TILE

# Function to print the grid world
def print_grid():
    for row in grid_world:
        print(' '.join(['#' if tile == WALL_TILE else '.' for tile in row]))
    print()

# Base class for NPCs
class NPC:
    def __init__(self, x, y, ai_strategy):
        self.x = x
        self.y = y
        self.ai_strategy = ai_strategy

    def move(self):
        # Move the NPC according to its AI strategy
        self.x, self.y = self.ai_strategy.calculate_move(self.x, self.y)

    def get_position(self):
        return self.x, self.y

# Base class for AI strategies
class AIStrategy:
    def calculate_move(self, x, y):
        # This method should be overridden by specific AI strategies
        pass

# Example AI strategy that moves randomly
class RandomMovementAI(AIStrategy):
    def calculate_move(self, x, y):
        return x + random.choice([-1, 0, 1]), y + random.choice([-1, 0, 1])

# A* Pathfinding Algorithm
class AStar:
    def __init__(self, grid):
        self.grid = grid
        self.width = len(grid[0])
        self.height = len(grid)

    def heuristic(self, a, b):
        # Manhattan distance on a square grid
        return abs(a[0] - b[0]) + abs(a[1] - b[1])

    def neighbors(self, node):
        dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        result = []
        for dir in dirs:
            next_node = (node[0] + dir[0], node[1] + dir[1])
            if 0 <= next_node[0] < self.width and 0 <= next_node[1] < self.height:
                if self.grid[next_node[1]][next_node[0]] != WALL_TILE:
                    result.append(next_node)
        return result

    def search(self, start, goal):
        frontier = []
        heapq.heappush(frontier, (0, start))
        came_from = {}
        cost_so_far = {}
        came_from[start] = None
        cost_so_far[start] = 0

        while not len(frontier) == 0:
            current = heapq.heappop(frontier)[1]

            if current == goal:
                break

            for next in self.neighbors(current):
                new_cost = cost_so_far[current] + 1
                if next not in cost_so_far or new_cost < cost_so_far[next]:
                    cost_so_far[next] = new_cost
                    priority = new_cost + self.heuristic(goal, next)
                    heapq.heappush(frontier, (priority, next))
                    came_from[next] = current

        # Reconstruct path
        current = goal
        path = []
        while current != start:
            path.append(current)
            current = came_from[current]
        path.reverse()
        return path

# A* Movement AI Strategy
class AStarMovementAI(AIStrategy):
    def __init__(self, grid, goal):
        self.astar = AStar(grid)
        self.goal = goal

    def calculate_move(self, x, y):
        path = self.astar.search((x, y), self.goal)
        if path:
            return path[0]  # Move to the next step on the path
        return x, y  # No path found, stay in place

# Function to simulate the game
def simulate_game(iterations, npcs):
    for _ in range(iterations):
        for npc in npcs:
            npc.move()
            print(f"NPC at position: {npc.get_position()}")

# Example usage
if __name__ == "__main__":
    # Add some walls to the grid
    add_walls([(1, 1), (2, 2), (3, 3)])
    print_grid()

    # Create NPCs with A* movement AI
    goal = (GRID_SIZE - 1, GRID_SIZE - 1)  # Bottom-right corner of the grid
    npcs = [NPC(0, 0, AStarMovementAI(grid_world, goal)) for _ in range(2)]

    # Simulate the game for 10 iterations
    simulate_game(10, npcs)

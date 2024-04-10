extends Reference

class AStarNode:
    var position = Vector2()
    var g_cost = INF  # Cost from start to node
    var h_cost = INF  # Heuristic cost from node to end
    var f_cost = INF  # Total cost (g_cost + h_cost)
    var parent = null  # Parent node for path tracing

    func _init(_position):
        position = _position

func heuristic_cost_estimate(start, goal):
    # Manhattan distance
    return abs(start.x - goal.x) + abs(start.y - goal.y)

func a_star(start_position, goal_position, grid):
    var open_set = {}
    var closed_set = {}
    var start_node = AStarNode.new(start_position)
    var goal_node = AStarNode.new(goal_position)
    start_node.g_cost = 0
    start_node.h_cost = heuristic_cost_estimate(start_position, goal_position)
    start_node.f_cost = start_node.h_cost
    open_set[start_position] = start_node

    while open_set.size() > 0:
        var current = null
        var current_f_cost = INF
        for id in open_set:
            if open_set[id].f_cost < current_f_cost:
                current = open_set[id]
                current_f_cost = current.f_cost
        if current.position == goal_position:
            return retrace_path(start_node, current)
        open_set.erase(current.position)
        closed_set[current.position] = true

        for neighbour_position in get_neighbour_positions(current.position, grid):
            if neighbour_position in closed_set:
                continue
            var tentative_g_cost = current.g_cost + 1  # Assuming uniform cost for simplicity
            var neighbour = open_set.get(neighbour_position) if neighbour_position in open_set else AStarNode.new(neighbour_position)
            if tentative_g_cost < neighbour.g_cost:
                neighbour.parent = current
                neighbour.g_cost = tentative_g_cost
                neighbour.h_cost = heuristic_cost_estimate(neighbour_position, goal_position)
                neighbour.f_cost = neighbour.g_cost + neighbour.h_cost
                open_set[neighbour_position] = neighbour

    return []  # No path found

func get_neighbour_positions(position, grid):
    var neighbours = []
    var directions = [
        Vector2(0, -1),  # Up
        Vector2(1, 0),   # Right
        Vector2(0, 1),   # Down
        Vector2(-1, 0)   # Left
    ]
    for direction in directions:
        var neighbour_position = position + direction
        if grid.is_position_walkable(neighbour_position):
            neighbours.append(neighbour_position)
    return neighbours

func retrace_path(start_node, end_node):
    var path = []
    var current_node = end_node
    while current_node != start_node:
        path.append(current_node.position)
        current_node = current_node.parent
    path.reverse()
    return path

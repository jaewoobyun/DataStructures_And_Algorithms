// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public enum Visit<T: Hashable> {
	case start //1
	case edge(Edge<T>) //2
}
// 1 -> Starting Vertex
// 2 -> Edge that leads to a path back to the starting vertex

public class Dijkstra<T:Hashable> {
	
	public typealias Graph = AdjacencyList<T>
	let graph: Graph
	
	public init(graph: Graph) {
		self.graph = graph
	}
	
	// MARK: - Helper Method
	
	// MARK: Tracing back to the start
	private func route(to destination: Vertex<T>, with paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
		var vertex = destination //1
		var path: [Edge<T>] = [] //2
		
		while let visit = paths[vertex], case .edge(let edge) = visit { //3
			path = [edge] + path //4
			vertex = edge.source //5
		}
		return path //6
	}
	/*
	1. Start at the destination vertex
	2. Create an array of edges to store the path
	3. As long as you have not reached the source case, continue to extract the next edge
	4. Add this edge to path
	5. Set the current vertex to the edge's source vertex. This moves you closer to the start vertex
	6. Once the while loop reaches the start case, you have completed the path and return it
	*/
	
	// MARK: Calculating total distance
	private func distance(to destination: Vertex<T>, with paths: [Vertex<T> : Visit<T>]) -> Double {
		let path = route(to: destination, with: paths) //1
		let distances = path.compactMap{ $0.weight } //2 (flatMap deprecated)
		return distances.reduce(0.0, +) //3
	}
	/*
	1. Construct the path to the destination vertex
	2. flatMap removes all the nil weights values from the paths
	3. reduce sums the weights of all the edges
	*/
	
	// MARK: Generating the shortest paths
	public func shortestPath(from start: Vertex<T>) -> [Vertex<T> : Visit<T>] {
		var paths: [Vertex<T> : Visit<T>] = [start: .start] //1
		
		//2
		var priorityQueue = PriorityQueue<Vertex<T>>(sort: {
			self.distance(to: $0, with: paths) <
			self.distance(to: $1, with: paths)
		})
		priorityQueue.enqueue(start) //3
		
		while let vertex = priorityQueue.dequeue() { //4
			for edge in graph.edges(from: vertex) { //5
				guard let weight = edge.weight else { //6
					continue
				}
				if paths[edge.destination] == nil || distance(to: vertex, with: paths) + weight < distance(to: edge.destination, with: paths) { //7
					paths[edge.destination] = .edge(edge)
					priorityQueue.enqueue(edge.destination)
				}
			}
		}
		
		return paths
		
	}
	/*
	1. Define paths and initialize it with the start vertex
	2. Create a min-priority queue to store the vertices that must be visited. The sort closure uses the distanc method you created to sort the vertices by their distance from the start vertex
	3. Enqueue the start vertex as the first vertex to visit
	
	4. continue Dijkstra's algorithm to find the shortest paths until you've visited all the vertices have been visited. This happens once the priority queue is empty.
	5. For the current vertex, you go through all its neighboring edges
	6. You make sure the edge has a weight. If not, you move on to the next edge.
	7. If the destination vertex has not been visited before or you've found a cheaper path, you update the path and add the neighboring vertex to the priority queue.
	*/
	
	// MARK: Finding a specific path
	public func shortestPath(to destination: Vertex<T>, paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
		return route(to: destination, with: paths)
	}
	
	
}


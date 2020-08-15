// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public class Prim<T: Hashable> {
	
	public typealias Graph = AdjacencyList<T>
	public init() {}
	
	// MARK: - Helper methods
	// MARK: Copying a graph
	internal func copyVertices(from graph: Graph, to graph2: Graph) {
		for vertex in graph.vertices {
			graph2.createVertex(data: vertex.data)
		}
	}
	
	// MARK: Finding edges
	internal func addAvailableEdges(
		for vertex: Vertex<T>, //1 The current vertex
		in graph: Graph, //2 The graph, where the current vertex is stored in
		check visited: Set<Vertex<T>>, //3 The vertices that have already been visited.
		to priorityQueue: inout PriorityQueue<Edge<T>>) { //4 The priority queue to add all potential edges.
		for edge in graph.edges(from: vertex) { //1. look at every edge adjacent to the current vertex.
			if !visited.contains(edge.destination) { //2. Check to see if the destination vertex has already been visited.
				priorityQueue.enqueue(edge) //3. If it hasn't been visited, add the edge to the priority queue.
			}
		}
	}
	
	// MARK: Producing a minimum spanning tree
	public func produceMinimumSpanningTree(for graph: Graph) -> (cost: Double, mst: Graph) { //1
		var cost = 0.0 //2
		let mst = Graph() //3
		var visited: Set<Vertex<T>> = [] //4
		var priorityQueue = PriorityQueue<Edge<T>>(sort: { //5
			$0.weight ?? 0.0 < $1.weight ?? 0.0
		})
		/*
		1. takes undirected graph and returns minimum spanning tree and its cost
		2. cost keeps track of the total weight of the edges in the minimum spanning tree
		3. this is a graph that will become your minimum spanning tree
		4. visited stores all vertices that have already been visited
		5. this is a min-priority queue to store edges
		*/
		
		copyVertices(from: graph, to: mst) //1
		
		guard let start = graph.vertices.first else { //2
			return (cost: cost, mst: mst)
		}
		
		visited.insert(start) //3
		addAvailableEdges(for: start, in: graph, check: visited, to: &priorityQueue) //4
		
		/*
		1. Copy all the vertices from the original graph to the minimum spanning tree
		2. Get the starting vertex from the graph
		3. Mark the starting vertex as visited
		4. Add all potential edges from the start vertex into the priority queue
		*/
		
		while let smallestEdge = priorityQueue.dequeue() { //1
			let vertex = smallestEdge.destination //2
			guard !visited.contains(vertex) else { //3
				continue
			}
			
			visited.insert(vertex) //4
			cost += smallestEdge.weight ?? 0.0 //5
			
			mst.add(.undirected, from: smallestEdge.source, to: smallestEdge.destination, weight: smallestEdge.weight) //6
			
			addAvailableEdges(for: vertex, in: graph, check: visited, to: &priorityQueue) //7
		}
		
		return (cost: cost, mst: mst) //8
		
		/*
		1. Continue Prim's algorithm till the queue of edges is empty
		2. Get the destination vertex
		3. If this vertex has been visited, restart the loop and get the next smallest edge
		4. Mark the destination vertex as visited.
		5. Add the edge's weight to the total cost.
		6. Add the smallest edge into the minimum spanning tree you are constructing
		7. Add the available edges from the current vertex
		8. Once the priorityQueue is empty, return the minimum cost, and minimum spanning tree.
		*/
		
	}
	
	
}

# Manual
## Links and Wall Links
`links(direction, id) = id2`  
Take a node `id`, go to `direction`, and the next node is `id2`.  
If `id` connects to the wall in the `direction`, then `id2` is `1`. // Why not -1? Something to think about.  

`wall_links(:, wall_id) = [id; direction]`  
`wall_id` is meaningless.  
`id` is the node that connects to the wall.  
`direction` is from wall to node.  

direction == 1: Liquid on the right  
direction == 2: Liquid on the left  
(Polarity is conserved!!!)  

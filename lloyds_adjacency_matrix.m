function A = lloyds_adjacency_matrix(xy, rc)
%{
Let "n" be the number of agents.

--- Inputs ---
xy: n by 2 array holding position data for agents
    e.g., xy(j,2) is the y coordinate for agent-j

rc: radius of communication (scalar) used by all agents

--- Outputs ---
A:  n by n adjacency matrix
    e.g., if A(i,j) = 1, then agent-i receives a signal from agent-j
          if A(i,j) = 0, then agent-i receives NO signal from agent-j
%}



end
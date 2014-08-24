module Qa
	class TreesController < ApplicationController
	
		def index
			@root_nodes = Node.root_nodes
		end
		
	end
end

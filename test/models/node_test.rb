require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  def node_with_parent klass=Node
  	klass.new summary: 'Blah blah.', parent: Node.new(summary: 'Blah!')
  end
  
  def node_without_parent klass=Node
    node = node_with_parent(klass)
    node.parent = nil
    node
  end
  
  test 'invalid without summary' do
  	[nil, '', ' '].each do |bad_value|
  		n = node_with_parent
  		n.summary = bad_value
			refute n.valid?, n.errors.to_yaml
		end
	end
  
  test 'valid with parent' do
    [].each do |klass|
      n = node_with_parent(klass)
      assert n.valid?, n.errors.to_yaml
    end
  end
  
  test 'invalid without parent' do
    [].each do |klass|
      n = node_without_parent(klass)
      refute n.valid?, n.errors.to_yaml
    end
  end
  
  test 'valid without parent' do
    [ Question ].each do |klass|
      n = node_without_parent(klass)
      assert n.valid?, n.errors.to_yaml
    end
  end
  
  test 'invalid with parent' do
    [ Question ].each do |klass|
      n = node_with_parent(klass)
      refute n.valid?, n.errors.to_yaml
    end
  end
end

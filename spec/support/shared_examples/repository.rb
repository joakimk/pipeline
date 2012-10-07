shared_examples :repository do
  # expects repository and entity_klass to be defined

  describe "add" do
    it "sets an id on the entity" do
      entity1 = build_valid_entity
      entity1.id.should be_nil
      repository.add(entity1)
      entity1.id.should > 0

      entity2 = build_valid_entity
      repository.add(entity2)
      entity2.id.should == entity1.id + 1
    end

    it "returns the id" do
      id = repository.add(build_valid_entity)
      id.should be_kind_of(Fixnum)
      id.should > 0
    end

    it "does not store by reference" do
      entity = build_valid_entity
      repository.add(entity)
      repository.last.object_id.should_not == entity.object_id
      repository.last.name.should == "test"
    end

    it "validates the record before saving" do
      entity = entity_klass.new
      repository.add(entity).should be_false
    end
  end

  private

  def build_valid_entity
    entity_klass.new(name: 'test')
  end
end

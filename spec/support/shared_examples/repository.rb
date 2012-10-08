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

  describe "update" do
    it "updates" do
      entity = build_valid_entity
      repository.add(entity)

      entity.name = "Updated"
      repository.last.name.should == "test"

      repository.update(entity)
      repository.last.id.should == entity.id
      repository.last.name.should == "Updated"
    end

    it "returns true" do
      entity = build_valid_entity
      repository.add(entity)
      repository.update(entity).should == true
    end

    it "fails when the entity does not have an id" do
      entity = build_valid_entity
      -> { repository.update(entity) }.should raise_error(Repository::Common::CanNotFindEntity)
    end

    it "fails when the entity no longer exists" do
      entity = build_valid_entity
      repository.add(entity)
      repository.delete_all
      -> { repository.update(entity) }.should raise_error(Repository::Common::CanNotFindEntity)
    end
  end

  describe "delete_all" do
    it "empties the repository" do
      repository.add(build_valid_entity)
      repository.delete_all
      repository.all.should == []
    end
  end

  describe "first" do
    it "returns the first entity" do
      first_added_entity = build_valid_entity
      repository.add(first_added_entity)
      repository.add(build_valid_entity)
      repository.first.id.should == first_added_entity.id
      repository.first.should be_kind_of(entity_klass)
    end
  end

  describe "last" do
    it "returns the last entity" do
      last_added_entity = build_valid_entity
      repository.add(build_valid_entity)
      repository.add(last_added_entity)
      repository.last.id.should == last_added_entity.id
      repository.last.should be_kind_of(entity_klass)
    end
  end

  describe "count" do
    it "returns the number of entities" do
      repository.add(build_valid_entity)
      repository.add(build_valid_entity)
      repository.count.should == 2
    end
  end

  describe "delete" do
    it "removes the entity" do
      entity = build_valid_entity
      repository.add(entity)
      repository.add(build_valid_entity)
      repository.delete(entity)
      repository.all.size.should == 1
      repository.first.id.should_not == entity.id
    end

    it "fails when the entity does not have an id" do
      entity = entity_klass.new
      -> { repository.delete(entity) }.should raise_error(Repository::Common::CanNotFindEntity)
    end

    it "fails when the entity can not be found" do
      entity = entity_klass.new(id: -1)
      -> { repository.delete(entity) }.should raise_error(Repository::Common::CanNotFindEntity)
    end
  end

  private

  def build_valid_entity
    entity_klass.new(name: 'test')
  end
end

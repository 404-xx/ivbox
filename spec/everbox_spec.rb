require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module EverBox

  module FSHelperMethods
    def collect_entries_as_array_from data
      directories = []
      data.select{|e| e.is_a?(Hash)}.each{|n| directories << n["path"]}
      directories
    end
  end
  
  module DeviceHelperMethods
    def collect_device_id_as_array_from data
      devices = []
      data.each{|n| devices << n["devId"]}
      devices
    end
  end

  describe FS do
    
    include FSHelperMethods
    
    before(:all) do
      @token = 'awhy404'
      @path0 = 'home/test'
      @path1 = 'home/test/dir1'
      @path2 = 'home/test/dir2'
      @path3 = 'home/test/dir2/dir1'
      
      @source_file = File.expand_path(__FILE__)
      @target_path = 'home/test/' + File.basename(__FILE__)
      
      EverBox::FS.mkdir(@token, @path0)
    end
    
    context "make dir" do
      it "should be successful when I create a new folder '/home/test/dir1'" do
        result = EverBox::FS.mkdir(@token, @path1)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should be successful when I create another folder '/home/test/dir2'" do
        result = EverBox::FS.mkdir(@token, @path2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should have some subdirectories under the '/home/test' directory" do
        result = EverBox::FS.get(@token, @path0, :show_list => 1, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
        data.should be_an_instance_of(Hash)
        entries = data["entries"]
        entries.should_not be_empty
        directories = collect_entries_as_array_from(entries)
        directories.should include '/' + @path1
        directories.should include '/' + @path2
      end
    end
    
    context "move dir" do
      it "should be successful when I move '/home/test/dir1' to 'home/test/dir2/dir1'" do
        result = EverBox::FS.move(@token, @path1, @path3)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should exists '/home/test/dir2/dir1' when I move '/home/test/dir1' to there" do
        result = EverBox::FS.get(@token, @path3, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should not exists '/home/test/dir1' when I move '/home/test/dir1' to '/home/test/dir2/dir1'" do
        result = EverBox::FS.get(@token, @path1, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 400
      end
    end
    
    context "copy dir" do
      it "should be successful when I copy '/home/test/dir2/dir1' to '/home/test/dir1'" do
        result = EverBox::FS.copy(@token, @path3, @path1)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should exists '/home/test/dir1' when I copy '/home/test/dir2/dir1' to '/home/test/dir1'" do
        result = EverBox::FS.get(@token, @path1, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
    end
    
    context "delete dir" do
      it "should be successful when I delete '/home/test'" do
        result = EverBox::FS.delete(@token, @path0)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should not exists '/home/test' when I deleted this path" do
        result = EverBox::FS.get(@token, @path0, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
        data["type"].should_not == 2
      end
    end
    
    context "revert dir" do
      it "should be successful when I revert '/home/test'" do
        result = EverBox::FS.undelete(@token, @path0)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should exists '/home/test' when I revert this path" do
        result = EverBox::FS.get(@token, @path0, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
    end
    
    context "upload a file" do
      it "should be successful" do
        result = EverBox::FS.upload(@token, @source_file, @target_path)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should be exists and can be able to download" do
        result = EverBox::FS.get(@token, @target_path, :show_type => 1)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
        url = data["dataurl"]
        url.should =~ %r{^http}
      end
    end
    
    context "get FS information" do
      it "should be successful" do
        result = EverBox::FS.info(@token)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
        data.should_not be_empty
      end
    end
    
    context "purge deleted" do
      it "should be successful when I delete '/home/test'" do
        result = EverBox::FS.delete(@token, @path0)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should be successful when I purge '/home/test'" do
        result = EverBox::FS.purge(@token, @path0)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 200
      end
      
      it "should not exists '/home/test' when I deleted this path" do
        result = EverBox::FS.get(@token, @path0, :show_type => 2)
        result.should be_an_instance_of(Array)
        code, data = result
        code.should == 400
      end
    end

  end
  
  describe Device do

    include DeviceHelperMethods

    before(:all) do
      @token = 'awhy404'
      @device_id = '{F5A22D89-0545-AB7E-5F0D-164819498742}'
      @device_name = 'My WorkPC'
    end

    it "should be successful when I add a new device" do
      result = EverBox::Device.set @token, @device_id, @device_name
      result.should be_an_instance_of(Array)
      code, data = result
      code.should == 200
    end

    it "should list all exists devices include that one added by me" do
      result = EverBox::Device.list @token
      result.should be_an_instance_of(Array)
      code, data = result
      code.should == 200
      data.should_not be_empty
      devices = collect_device_id_as_array_from data["devices"]
      devices.should include @device_id
    end

    it "should be removed when I unlink the device" do
      result = EverBox::Device.unlink @token, @device_id
      result.should be_an_instance_of(Array)
      code, data = result
      code.should == 200
    end

    it "should not exists that device which is added by me" do
      result = EverBox::Device.list @token
      result.should be_an_instance_of(Array)
      code, data = result
      code.should == 200
      devices = collect_device_id_as_array_from data["devices"]
      devices.should_not include @device_id
    end

  end
end

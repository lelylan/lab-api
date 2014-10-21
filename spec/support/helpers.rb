# Helper methods

# fixtures related
def fixture_path
  File.expand_path('../../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def json_fixture(file)
  HashWithIndifferentAccess.new JSON.parse fixture(file).read
end

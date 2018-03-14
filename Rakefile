# <Lenovo copyright to be inserted>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

require 'bundler'
require 'bundler/setup'
require 'rspec/core/rake_task'

task default: :unit

desc 'Run unit tests'
RSpec::Core::RakeTask.new(:unit) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = '--color '
end


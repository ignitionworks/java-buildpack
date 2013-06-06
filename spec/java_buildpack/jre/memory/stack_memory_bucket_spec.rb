# Cloud Foundry Java Buildpack
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'
require 'java_buildpack/jre/memory/stack_memory_bucket'
require 'java_buildpack/jre/memory/memory_bucket'
require 'java_buildpack/jre/memory/memory_size'

describe JavaBuildpack::StackMemoryBucket do

  TEST_STACK_BUCKET_NAME = 'stack-bucket'
  TEST_STACK_BUCKET_WEIGHTING = 0.05
  TEST_STACK_SIZE = JavaBuildpack::MemorySize.new('2M')
  TEST_STACK_MEMORY_BUCKET_TOTAL_MEMORY = JavaBuildpack::MemorySize.new('1G')
  DEFAULT_STACK_SIZE = JavaBuildpack::MemorySize.new('1M')

  it 'should call the superclass constructor correctly' do
    # since we can't easily stub the superclass, test the superclass behaves as expected
    stack_memory_bucket = JavaBuildpack::StackMemoryBucket.new(TEST_STACK_BUCKET_WEIGHTING, TEST_STACK_SIZE, TEST_STACK_MEMORY_BUCKET_TOTAL_MEMORY)
    expect(stack_memory_bucket.size).to eq(TEST_STACK_SIZE)
  end

  it 'should calculate the excess memory correctly' do
    stack_memory_bucket = JavaBuildpack::StackMemoryBucket.new(TEST_STACK_BUCKET_WEIGHTING, TEST_STACK_SIZE, TEST_STACK_MEMORY_BUCKET_TOTAL_MEMORY)
    expect(stack_memory_bucket.excess).to eq(TEST_STACK_MEMORY_BUCKET_TOTAL_MEMORY * ((TEST_STACK_SIZE - DEFAULT_STACK_SIZE)/DEFAULT_STACK_SIZE) * TEST_STACK_BUCKET_WEIGHTING)
  end

  it 'should use the correct default size if size has not been set' do
    stack_memory_bucket = JavaBuildpack::StackMemoryBucket.new(TEST_STACK_BUCKET_WEIGHTING, nil, TEST_STACK_MEMORY_BUCKET_TOTAL_MEMORY)
    expect(stack_memory_bucket.size).to eq(DEFAULT_STACK_SIZE)
  end

end
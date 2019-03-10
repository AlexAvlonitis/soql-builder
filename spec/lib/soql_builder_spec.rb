require 'spec_helper'
require 'soql_builder'

describe SoqlBuilder do
  let(:subject) { described_class.new(type: :select) }
  let(:interface_instance) { instance_double(SoqlBuilder::Interface) }

  before do
    allow(SoqlBuilder::Interface)
      .to receive(:new)
      .with(type: :select)
      .and_return(interface_instance)
  end

  describe '.new' do
    context 'when send the "new" message to the module' do
      it 'generates an interface instance' do
        expect(SoqlBuilder::Interface)
          .to receive(:new)
          .with(type: :select)
          .and_return(interface_instance)

        subject
      end
    end
  end
end

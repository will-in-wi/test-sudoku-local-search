require 'square'

RSpec.describe Square do
  let(:value) { nil }
  let(:square) { Square.new value }

  it 'has no value' do
    expect(square.value).to be_nil
  end

  it 'is not original' do
    expect(square.original?).to eq false
  end

  describe '#nil?' do
    it 'is true when blank' do
      expect(square.nil?).to eq true
    end

    it 'is false when not blank' do
      square.value = 2
      expect(square.nil?).to eq false
    end
  end

  context 'with initial value' do
    let(:value) { 2 }

    it 'has value' do
      expect(square.value).to eq 2
    end

    it 'is original' do
      expect(square.original?).to eq true
    end

    it 'does not allow assignment' do
      expect do
        square.value = 3
      end.to raise_error ArgumentError, 'Cannot change original square'
    end
  end

  context 'with invalid initial value' do
    let(:value) { 10 }

    it 'fails to initialize' do
      expect { square }.to raise_error ArgumentError, 'Argument out of bounds'
    end
  end

  describe '#value=' do
    it 'allows assignment' do
      square.value = 4
      expect(square.value).to eq 4
    end

    it 'validates scope' do
      expect do
        square.value = 10
      end.to raise_error ArgumentError, 'Argument out of bounds'
    end
  end
end

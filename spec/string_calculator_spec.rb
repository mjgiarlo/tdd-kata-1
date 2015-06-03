require 'spec_helper'

describe StringCalculator do
  subject { StringCalculator::StringCalculator.new }
  describe '#add' do
    it 'is defined' do
      expect(subject).to respond_to(:add)
    end

    context 'with an empty string' do
      let(:arg) { '' }
      it 'returns 0' do
        expect(subject.add(arg)).to eq 0
      end
    end

    context 'with a string containing a single number' do
      let(:arg) { '1' }
      it 'returns 1' do
        expect(subject.add(arg)).to eq 1
      end

      context 'when the number is negative' do
        let(:arg) { '-1' }
        it 'raises an error' do
          expect { subject.add(arg) }.to raise_error('negatives not allowed: [-1]')
        end
      end
    end

    context 'with a string containing two, comma-separated numbers' do
      let(:arg) { '1,3' }
      it 'returns 4' do
        expect(subject.add(arg)).to eq 4
      end

      context 'when the numbers are negative' do
        let(:arg) { '-1, -4' }
        it 'raises an error' do
          expect { subject.add(arg) }.to raise_error('negatives not allowed: [-1, -4]')
        end
      end

      context 'when one number is > 1000' do
        let(:arg) { '20, 1100' }
        it 'returns 20, ignoring the big number' do
          expect(subject.add(arg)).to eq 20
        end
      end

      context 'when all numbers are > 1000' do
        let(:arg) { '1001, 1100' }
        it 'returns 0, ignoring the big numbers' do
          expect(subject.add(arg)).to eq 0
        end
      end
    end

    context 'with a string containing a bunch of numbers' do
      context 'with comma delimiters' do
        let(:arg) { '4, 36, 72' }
        it 'returns 112' do
          expect(subject.add(arg)).to eq 112
        end
      end

      context 'with newline delimiters' do
        let(:arg) { "4\n3\n2" }
        it 'returns 9' do
          expect(subject.add(arg)).to eq 9
        end
      end

      context 'with mixed delimiters' do
        let(:arg) { "4,3\n7,2" }
        it 'returns 16' do
          expect(subject.add(arg)).to eq 16
        end
      end

      context 'with a specified delimiter' do
        let(:arg) { "//;\n1;2,3\n4" }
        it 'returns 10' do
          expect(subject.add(arg)).to eq 10
        end
      end

      context 'with a specified multi-character delimiter' do
        let(:arg) { "//[***]\n2***4,6***8" }
        it 'returns 20' do
          expect(subject.add(arg)).to eq 20
        end
      end

      context 'with multiple specified delimiters' do
        let(:arg) { "//[*][%][a][b][c]\n1*2%3,4\n5" }
        it 'returns 15' do
          expect(subject.add(arg)).to eq 15
        end
      end

      context 'with multiple specified multi-character delimiters' do
        let(:arg) { "//[**][%%%][abc]\n1**2%%%3,4abc5\n6" }
        it 'returns 21' do
          expect(subject.add(arg)).to eq 21
        end
      end
    end
  end
end

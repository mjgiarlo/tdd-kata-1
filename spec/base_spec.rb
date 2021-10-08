# frozen_string_literal: true

require 'spec_helper'

describe StringCalculator do
  describe 'public API' do
    subject { described_class.new }

    it 'is defined' do
      expect(subject).to respond_to(:add)
    end
  end

  describe '#add' do
    subject { described_class.new.add(arg) }

    context 'with an empty string' do
      let(:arg) { '' }

      it { is_expected.to eq 0 }
    end

    context 'with a string containing a single number' do
      let(:arg) { '1' }

      it { is_expected.to eq 1 }

      context 'when the number is negative' do
        let(:arg) { '-1' }

        # is_expected does not work with the raise_error matcher
        it 'raises an error' do
          expect { subject.add(arg) }.to raise_error('negatives not allowed: [-1]')
        end
      end
    end

    context 'with a string containing two, comma-separated numbers' do
      let(:arg) { '1,3' }

      it { is_expected.to eq 4 }

      context 'when the numbers are negative' do
        let(:arg) { '-1, -4' }

        # is_expected does not work with the raise_error matcher
        it 'raises an error' do
          expect { subject.add(arg) }.to raise_error('negatives not allowed: [-1, -4]')
        end
      end

      context 'when one number is > 1000' do
        let(:arg) { '20, 1100' }

        it { is_expected.to eq 20 }
      end

      context 'when all numbers are > 1000' do
        let(:arg) { '1001, 1100' }

        it { is_expected.to eq 0 }
      end
    end

    context 'with a string containing a bunch of numbers' do
      context 'with comma delimiters' do
        let(:arg) { '4, 36, 72' }

        it { is_expected.to eq 112 }
      end

      context 'with newline delimiters' do
        let(:arg) { "4\n3\n2" }

        it { is_expected.to eq 9 }
      end

      context 'with mixed delimiters' do
        let(:arg) { "4,3\n7,2" }

        it { is_expected.to eq 16 }
      end

      context 'with a specified delimiter' do
        let(:arg) { "//;\n1;2,3\n4" }

        it { is_expected.to eq 10 }
      end

      context 'with a specified multi-character delimiter' do
        let(:arg) { "//[***]\n2***4,6***8" }

        it { is_expected.to eq 20 }
      end

      context 'with multiple specified delimiters' do
        let(:arg) { "//[*][%][a][b][c]\n1*2%3,4\n5" }

        it { is_expected.to eq 15 }
      end

      context 'with multiple specified multi-character delimiters' do
        let(:arg) { "//[**][%%%][abc]\n1**2%%%3,4abc5\n6" }

        it { is_expected.to eq 21 }
      end
    end
  end
end

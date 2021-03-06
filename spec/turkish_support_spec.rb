require 'spec_helper'
using TurkishSupport

module TurkishSupport
  describe VERSION do
    it 'should have a version number' do
      TurkishSupport::VERSION.should_not be_nil
    end
  end

  describe String do
    let(:downcased_turkish_alphabet) { "abcçdefgğhıijklmnoöprsştuüvyz" }
    let(:upcased_turkish_alphabet)   { "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ" }
    let(:downcased_english_alphabet) { [*'a'..'z'].join }
    let(:upcased_english_alphabet)   { [*'A'..'Z'].join }
    let(:turkish_words)              {  %w(çamur ıhlamur insan ördek şahika ümraniye) }

    describe "#upcase" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          expect{ downcased_turkish_alphabet.upcase }.to_not change{ downcased_turkish_alphabet }
        end

        it "upcases all of Turkish characters" do
          upcased_string = downcased_turkish_alphabet.upcase
          expect(upcased_string).to eq( upcased_turkish_alphabet )
        end

        it "upcases English characters except i as I" do
          upcased_string = downcased_english_alphabet.upcase
          expect(upcased_string).to eq( upcased_english_alphabet.tr('I', 'İ'))
        end
      end

      context "with destructive version" do
        it "changes the original value of the string with the upcased version" do
          expect{ downcased_turkish_alphabet.upcase! }.to change{ downcased_turkish_alphabet }
          expect( downcased_turkish_alphabet).to eq( upcased_turkish_alphabet )
        end
      end
    end

    describe "#downcase" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          expect{ upcased_turkish_alphabet.downcase }.to_not change{ upcased_turkish_alphabet }
        end

        it "downcases all of Turkish characters" do
          downcased_string = upcased_turkish_alphabet.downcase
          expect(downcased_string).to eq( downcased_turkish_alphabet )
        end

        it "downcases English characters except I as ı" do
          downcased_string = upcased_english_alphabet.downcase
          expect(downcased_string).to eq( downcased_english_alphabet.tr('i', 'ı'))
        end
      end

      context "with destructive version" do
        it "changes the original value of the string with the downcased version" do
          expect{ upcased_turkish_alphabet.downcase! }.to change{ upcased_turkish_alphabet }
          expect( upcased_turkish_alphabet).to eq(downcased_turkish_alphabet)
        end
      end
    end

    describe "#capitalize" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          turkish_word = turkish_words.sample
          expect{ turkish_word.capitalize }.to_not change{ turkish_word }
        end

        it "capitalizes the first character of a string that starts with an unsupported Turkish character" do
          capitalized_words = turkish_words.map{ |w| w.capitalize }
          expect(capitalized_words).to eq(%w[Çamur Ihlamur İnsan Ördek Şahika Ümraniye])
        end

        it "capitalizes the first character of an English string" do
          english_word = "spy"
          capitalized_string = english_word.capitalize
          expect(capitalized_string).to eq("Spy")
        end
      end

      context "with destructive version" do
        it "changes the original value of the string with the capitalized version" do
          turkish_word = 'çamur'
          expect{ turkish_word.capitalize! }.to change{ turkish_word }
          expect(turkish_word).to eq('Çamur')
        end
      end
    end

    describe "#casecmp" do
      it "compares Turkish characters correctly" do
        result = downcased_turkish_alphabet.casecmp(upcased_turkish_alphabet)
        expect(result).to be_zero
      end
    end

    describe "#titleize" do
      it "upcases first character of all words" do
        titleized = "merhaba çamur ismet".titleize
        expect(titleized).to eq("Merhaba Çamur İsmet")
      end

      it "downcases characters other than first characters of all words" do
        titleized = "mERHABA çAMUR iSMETOĞULLARI".titleize
        expect(titleized).to eq("Merhaba Çamur İsmetoğulları")
      end
    end

    describe "#swapcase" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          word = "mErHaba çamur ismetoğullarI"
          expect{ word.swapcase }.to_not change{ word }
        end

        it "swaps characters correctly" do
          word = "mErHaba çamur ismetoğullarI".swapcase
          expect(word).to eq("MeRhABA ÇAMUR İSMETOĞULLARı")
        end
      end

      context "with destructive version" do
        it "changes the original value of the string with the swapcased version" do
          word = "mErHaba çamur ismetoğullarI"
          expect{ word.swapcase! }.to change{ word }
          expect(word).to eq('MeRhABA ÇAMUR İSMETOĞULLARı')
        end
      end
    end

  end

  describe Array do
    let(:unsorted_array1) { ["bağcılar", "bahçelievler", "şimdi", "çüNKÜ", "olmalı", "üç kere", "düş", "ılık", "duy"] }
    let(:sorted_array1) { ["bağcılar", "bahçelievler", "çüNKÜ", "duy", "düş", "ılık", "olmalı", "şimdi", "üç kere"] }
    let(:unsorted_array2) { ["iki", "üç", "dört", "ılık", "iğne", "iyne", "ul"] }
    let(:sorted_array2) { ["dört", "ılık", "iğne", "iki", "iyne", "ul", "üç"] }

    describe "#sort" do
      it "does sort array in alphabetical order" do
        expect(unsorted_array1.sort).to eq(sorted_array1)
      end
      it "does sort array in alphabetical order" do
        expect(unsorted_array2.sort).to eq(sorted_array2)
      end
    end
  end

end

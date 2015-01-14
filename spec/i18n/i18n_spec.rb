require 'spec_helper'
require 'i18n/tasks'

describe 'I18n' do
  let(:i18n) { I18n::Tasks::BaseTask.new }
  let(:missing_keys) { i18n.missing_keys }
  let(:unused_keys) { i18n.unused_keys }

  xit 'нет отсутствующих ключей' do
    expect(missing_keys).to be_empty, 
          "Отсутствуют #{missing_keys.leaves.count} i18n ключей, команда `i18n-tasks missing' покажет их"
  end

  xit 'нет неиспользуемых ключей' do
    expect(i18n.unused_keys).to be_empty,
          "#{unused_keys.leaves.count} неиспользуемых i18n ключей, команда `i18n-tasks unused' покажет их"
  end
end

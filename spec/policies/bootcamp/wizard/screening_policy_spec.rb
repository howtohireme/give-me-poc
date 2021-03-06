# frozen_string_literal: true

require 'rails_helper'

describe Bootcamp::Wizard::ScreeningPolicy do
  subject { described_class.new(user, nil) }

  context 'unauthenticated user' do
    let(:user) { nil }
    it { is_expected.not_to permit_action(:edit) }
  end

  context 'pending user' do
    let(:user) { create(:user, :member) }
    it { is_expected.not_to permit_action(:edit) }
  end

  context 'policy_accepted user' do
    let(:user) { create(:user, :member, :policy_accepted) }
    it { is_expected.to permit_action(:edit) }
  end

  context 'screening_completed user' do
    let(:user) { create(:user, :member, :screening_completed) }
    it { is_expected.to permit_action(:edit) }
  end

  context 'active user' do
    let(:user) { create(:user, :member, :active) }
    it { is_expected.not_to permit_action(:edit) }
  end

  context 'disabled user' do
    let(:user) { create(:user, :member, :disabled) }
    it { is_expected.not_to permit_action(:edit) }
  end

  context 'rejected user' do
    let(:user) { create(:user, :member, :rejected) }
    it { is_expected.not_to permit_action(:edit) }
  end
end

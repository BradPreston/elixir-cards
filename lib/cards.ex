defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = [
      "Spades",
      "Clubs",
      "Hearts",
      "Diamonds"
    ]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffles the cards in a deck.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.shuffle(deck)

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves a deck to the file system.
  The `deck` is the saved with the `filename`.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "test")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.mkdir("tmp")
    File.write("tmp/#{filename}", binary)
  end

  @doc """
  Loads a deck from the file system.
  The file is found via the `filename`.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "test")
      iex> Cards.load("test")
      deck

  """
  def load(filename) do
    case File.read("tmp/#{filename}") do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
  Creates a hand out of a deck. `hand_size` will be how many
  cards are dealt.

  ## Examples

      iex> hand = Cards.create_hand(5)
      hand

  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end

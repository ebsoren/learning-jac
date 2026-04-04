sv {    enum Decision {
        buy = 1,
        sell = 2,
        hold = 3,
    }
    sem Decision.buy = "Buy the stock";
    sem Decision.sell = "Sell the stock";
    sem Decision.hold = "Hold and do nothing";

    obj Agent {
        id: int = 0;
        instructions: str = "";

        def Decide(stock: Stock) -> Decision by llm(
            incl_info={"instructions": self.instructions}
        );

        def Instruct(instr: str) {
            self.instructions = instr;
        }
    }


    enum StockValue {
        undervalued,
        overvalued,
        fairValue,
    }

    obj Stock {
        has price: int = 100;
        has valuation: StockValue = StockValue.fairValue;
    }


    with entry {
        agent = Agent(id = 0);
        stock = Stock();
        stock.valuation = StockValue.undervalued;
        print(agent.id);
        agent.Instruct("Buy stocks that are undervalued. Sell stocks that are overvalued. Do nothing on a fair stock.");
        choice: Decision = agent.Decide(stock);
        switch(choice){
            case Decision.buy:
                print("Bought");
                break;
            
            case Decision.sell:
                print("Sold");
                break;
            
            case Decision.hold:
                print("Held");
                break;
        }

    }
}

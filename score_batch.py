
# score_batch.py  auto generated
import pandas as pd
import numpy as np
from pathlib import Path
import joblib

MODELS_DIR = Path(r"C:\Users\swati\Desktop\BPIS\models")

churn = joblib.load(MODELS_DIR / "churn_model.pkl")
demand = joblib.load(MODELS_DIR / "demand_model.pkl")

def preprocess(df):
    df['order_date'] = pd.to_datetime(df['order_date'], errors='coerce')
    df['price'] = (df['sales']/df['quantity']).replace([np.inf,-np.inf],0)
    df['month_year_str'] = df['order_date'].dt.to_period('M').astype(str)
    return df

def score(input_path, output_path):
    df = pd.read_csv(score(r"C:\Users\swati\Desktop\BPIS\input.csv", r"C:\Users\swati\Desktop\BPIS\output_scored.csv")
)
    df = preprocess(df)

    # demand scoring
    X = df[['price','discount','quantity','profit_margin']].fillna(0)
    df['predicted_sales'] = demand.predict(X)

    # churn scoring
    cust = df.groupby('customer_id').agg({
        'order_date':'max',
        'order_id':'nunique',
        'sales':'sum'
    }).rename(columns={'order_id':'frequency','sales':'monetary'}).reset_index()

    cust['recency_days'] = (df['order_date'].max() - cust['order_date']).dt.days
    cust['CLTV_pred'] = cust['monetary'] * 0.1   # fallback if CLTV not present

    Xc = cust[['recency_days','frequency','monetary','CLTV_pred']].fillna(0)
    cust['churn_proba'] = churn.predict_proba(Xc)[:,1]

    out = df.merge(cust[['customer_id','churn_proba']], on='customer_id', how='left')
    out.to_csv(output_path, index=False)
    print("Saved:", output_path)

if __name__ == "__main__":
    score("input.csv","output_scored.csv")

//
//  MarketData.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

// JSON data:
/*
 ULR:
 https://api.coingecko.com/api/v3/global
 Response:
 {
 "data": {
 "active_cryptocurrencies": 10883,
 "upcoming_icos": 0,
 "ongoing_icos": 50,
 "ended_icos": 3375,
 "markets": 678,
 "total_market_cap": {
 "btc": 45806903.03777784,
 "eth": 647695400.5937072,
 "ltc": 12176409138.542862,
 "bch": 4684423683.360634,
 "bnb": 4778698401.404589,
 "eos": 636118796376.7932,
 "xrp": 2520018982139.355,
 "xlm": 7958298521252.672,
 "link": 94976933182.08142,
 "dot": 65226310095.19966,
 "yfi": 88524137.63939649,
 "usd": 2761518864449.446,
 "aed": 10143047743047.357,
 "ars": 277178972633161.6,
 "aud": 3801026364518.693,
 "bdt": 237350251577253.56,
 "bhd": 1041285918217.9512,
 "bmd": 2761518864449.446,
 "brl": 15271751624178.31,
 "cad": 3483752700663.233,
 "chf": 2564111688424.2754,
 "clp": 2281563246126268,
 "cny": 17612967317458.56,
 "czk": 61513940074675.89,
 "dkk": 18141723618991.293,
 "eur": 2439611371939.437,
 "gbp": 2046677614235.7903,
 "hkd": 21507302642888.145,
 "huf": 888900121145203.1,
 "idr": 39297241896774940,
 "ils": 8496326428987.522,
 "inr": 205077162118271.4,
 "jpy": 315351646725804.56,
 "krw": 3260743212616902,
 "kwd": 835577616486.25,
 "lkr": 558873075555519.8,
 "mmk": 4896296430746396,
 "mxn": 57040613658050.445,
 "myr": 11540387334534.236,
 "ngn": 1137272790248144.5,
 "nok": 24135669352250.43,
 "nzd": 3945138987978.8506,
 "php": 139180561814327.73,
 "pkr": 483446793986550.1,
 "pln": 11371133843332.127,
 "rub": 200500077153351.88,
 "sar": 10357626043371.648,
 "sek": 24483084994511.36,
 "sgd": 3743708278968.182,
 "thb": 90106060201771.19,
 "try": 29382878292411.5,
 "twd": 76646232234680.98,
 "uah": 73268135245771.3,
 "vef": 276510883897.323,
 "vnd": 62592208145827360,
 "zar": 42831096834195.87,
 "xdr": 1965690550498.0825,
 "xag": 110093113571.5535,
 "xau": 1478986658.2331886,
 "bits": 45806903037777.84,
 "sats": 4580690303777784
 },
 "total_volume": {
 "btc": 2745042.8917439273,
 "eth": 38814055.033335924,
 "ltc": 729688390.528319,
 "bch": 280720657.3935154,
 "bnb": 286370202.0576524,
 "eos": 38120310793.74032,
 "xrp": 151015670897.38324,
 "xlm": 476912197450.33057,
 "link": 5691625890.885774,
 "dot": 3908778088.1813335,
 "yfi": 5304933.0703360895,
 "usd": 165487889958.89853,
 "aed": 607836357867.4744,
 "ars": 16610338575826.488,
 "aud": 227781834424.56683,
 "bdt": 14223546621530.773,
 "bhd": 62400518666.80178,
 "bmd": 165487889958.89853,
 "brl": 915181129050.6997,
 "cad": 208768765259.2991,
 "chf": 153657988145.18652,
 "clp": 136725876571002.94,
 "cny": 1055481762157.8542,
 "czk": 3686309109478.328,
 "dkk": 1087168224911.9548,
 "eur": 146197132114.27957,
 "gbp": 122650025739.9179,
 "hkd": 1288855266896.243,
 "huf": 53268586112612.4,
 "idr": 2354942320482113,
 "ils": 509154274206.0845,
 "inr": 12289536484653.979,
 "jpy": 18897889593856.42,
 "krw": 195404608999964.9,
 "kwd": 50073160255.87362,
 "lkr": 33491252665029.97,
 "mmk": 293417428853613.6,
 "mxn": 3418238751779.601,
 "myr": 691573892138.237,
 "ngn": 68152666559225.59,
 "nok": 1446363827264.9932,
 "nzd": 236417985449.96185,
 "php": 8340590315880.057,
 "pkr": 28971226984603.168,
 "pln": 681431139362.6559,
 "rub": 12015248250465.816,
 "sar": 620695263380.9493,
 "sek": 1467183196749.1626,
 "sgd": 224346967780.58005,
 "thb": 5399731997946.514,
 "try": 1760810180270.0244,
 "twd": 4593132934598.233,
 "uah": 4390695736008.745,
 "vef": 16570302421.584507,
 "vnd": 3750925835513434.5,
 "zar": 2566713532528.9355,
 "xdr": 117796762391.09335,
 "xag": 6597484195.565701,
 "xau": 88630349.22528721,
 "bits": 2745042891743.9272,
 "sats": 274504289174392.72
 },
 "market_cap_percentage": {
 "btc": 41.208280298784665,
 "eth": 18.27521574954983,
 "bnb": 3.530591005889349,
 "usdt": 2.725554180112034,
 "sol": 2.3890668064944816,
 "ada": 2.17247723404775,
 "xrp": 1.8735626216792727,
 "dot": 1.6082081815846268,
 "usdc": 1.255183165879105,
 "doge": 1.1386431143302023
 },
 "market_cap_change_percentage_24h_usd": -0.7446550163472817,
 "updated_at": 1637191608
 }
 }
*/

import Foundation

// MARK: - MarketData
struct GlobalData: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var MarketCap: String {
        if let cap = totalMarketCap.first(where: { $0.key == "sar" }) {
            return "SAR " + cap.value.formattedWithAbbreviations()
        }
        return ""
    }

    var volume: String {
        if let volume = totalVolume.first(where: { $0.key == "sar" }) {
            return "SAR " + volume.value.formattedWithAbbreviations()
        }
        return ""
    }

    var btcDominance: String {
        if let dom = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return dom.value.asPercentString()
        }
        return ""
    }
}


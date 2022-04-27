package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.response.TransactionResponse;

import java.util.List;
import java.util.Map;

public interface ITransactionService {
    List<TransactionResponse> getTransactions(Long customerId);
    List<TransactionResponse> findAllTransaction(Long customerId);
}

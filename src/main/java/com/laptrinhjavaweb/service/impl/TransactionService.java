package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.converter.TransactionConverter;
import com.laptrinhjavaweb.dto.response.TransactionResponse;
import com.laptrinhjavaweb.entity.TransactionEntity;
import com.laptrinhjavaweb.enums.DistrictsEnum;
import com.laptrinhjavaweb.enums.TransactionsEnum;
import com.laptrinhjavaweb.repository.TransactionRepository;
import com.laptrinhjavaweb.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TransactionService implements ITransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private TransactionConverter transactionConverter;

    @Override
    public List<TransactionResponse> getTransactions(Long customerId) {
        List<TransactionResponse> transactions = new ArrayList<>();
        for (TransactionsEnum item: TransactionsEnum.values()) {
            TransactionResponse transactionResponse = new TransactionResponse();
            transactionResponse.setId(customerId);
            transactionResponse.setCode(item.toString());
            transactionResponse.setName(item.getTransactionValue());
            transactions.add(transactionResponse);
        }
        return transactions;
    }

    @Override
    public List<TransactionResponse> findAllTransaction(Long customerId) {
        List<TransactionResponse> result = new ArrayList<>();
        List<TransactionEntity> transactionEntities = transactionRepository.findAllByCustomerId(customerId);
        for(TransactionEntity item : transactionEntities){
            TransactionResponse transactionResponse = transactionConverter.convertToResponse(item);
            result.add(transactionResponse);
        }
        return result;
    }


}
